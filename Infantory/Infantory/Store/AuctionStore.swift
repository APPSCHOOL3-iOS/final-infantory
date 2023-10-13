import Foundation
import Firebase
import Combine

class AuctionStore: ObservableObject {
    @Published var product: AuctionProduct
    @Published var biddingInfos: [BiddingInfo] = []
    
    var increment: Int = 0
    
    private var dbRef: DatabaseReference!
    
    private let firestore = Firestore.firestore()
    
    init(product: AuctionProduct) {
        self.product = product
        self.dbRef = Database.database().reference()
        fetchData()
    }
    
    func fetchData() {
        guard let productId = product.id else { return }
        
        dbRef.child("biddingInfos/\(productId)")
            .queryOrdered(byChild: "timeStamp")
            .queryLimited(toLast: 10)
            .observe(.value, with: { snapshot in
                var parsedBiddingInfos: [BiddingInfo] = []
                
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let bidData = childSnapshot.value as? [String: Any],
                       let userID = bidData["userID"] as? String,
                       let userNickname = bidData["userNickname"] as? String,
                       let biddingPrice = bidData["biddingPrice"] as? Int,
                       let timeStamp = (bidData["timeStamp"] as? Double).map({ Date(timeIntervalSince1970: $0) }) {
                        
                        let biddingInfo = BiddingInfo(
                            id: UUID(uuidString: childSnapshot.key) ?? UUID(),
                            timeStamp: timeStamp,
                            userID: userID,
                            userNickname: userNickname,
                            biddingPrice: biddingPrice
                        )
                        
                        parsedBiddingInfos.append(biddingInfo)
                        
                    }
                }
                self.biddingInfos = parsedBiddingInfos
            })
    }
    
    func addBid(biddingInfo: BiddingInfo) {
        // 새로운 bid 참조 생성
        guard let productId = product.id else { return }
        
        let newBidRef = dbRef.child("biddingInfos/\(productId)").childByAutoId()
        
        // BiddingInfo를 [String: Any] 형태로 변환
        let bidData: [String: Any] = [
            "timeStamp": biddingInfo.timeStamp.timeIntervalSince1970,
            "userID": biddingInfo.userID,
            "userNickname": biddingInfo.userNickname,
            "biddingPrice": biddingInfo.biddingPrice
        ]
        // 데이터 쓰기
        newBidRef.setValue(bidData)
        updateWinningPrice(winningPrice: biddingInfo.biddingPrice)
        
        let productInfo = AuctionActivityInfo(productId: productId,
                                              price: biddingInfo.biddingPrice,
                                              timestamp: biddingInfo.timeStamp.timeIntervalSince1970)
        
        updateAuctionActivityInfo(productInfo: productInfo)
    }
    
    func updateAuctionActivityInfo(productInfo: AuctionActivityInfo) {
            firestore.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                .getDocument { document, _ in
                    guard var user = try? document?.data(as: User.self) else {
                        print("DEBUG: Failed to decode User not exist")
                        return
                    }
                    
                    // 만약 같은 productId가 이미 존재한다면, 해당 정보를 업데이트합니다.
                    if let index = user.auctionActivityInfos?.firstIndex(where: { $0.productId == productInfo.productId }) {
                        user.auctionActivityInfos?[index] = productInfo
                    } else {
                        // 존재하지 않으면 추가합니다.
                        user.auctionActivityInfos?.append(productInfo)
                    }
                    
                    // Firestore에 업데이트하기 위해 Codable 배열을 딕셔너리 배열로 변환합니다.
                    if let infos = user.auctionActivityInfos {
                        let auctionActivityInfosData = try? infos.map { try $0.asDictionary() }
                        self.firestore.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                            .updateData(["auctionActivityInfos": auctionActivityInfosData ?? []])
                    }
                }
        }

    func updateWinningPrice(winningPrice: Int) {
        guard let productId = product.id else { return }
        
        firestore.collection("AuctionProducts").document(productId).updateData([
            "winningPrice": winningPrice
        ]) { error in
            if let error = error {
                print("updating Error: \(error)")
            } else {
                print("successfully updated!")
            }
        }
    }
    
    var remainingTime: Double {
        return product.endDate.timeIntervalSince(Date())
    }
    
    var bidIncrement: Int {
        let standardPrice = (biddingInfos.last?.biddingPrice ?? 1)
        if standardPrice < 50000 {
            return 2000
        } else if standardPrice < 100000 {
            return 5000
        } else if standardPrice < 500000 {
            return 10000
        } else {
            return 50000
        }
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw EncodableError.serializationFailed
        }
        return dictionary
    }
}

// 추후에 에러끼리 enum으로 묶어서 정리해도 괜찮을 듯
enum EncodableError: Error {
    case serializationFailed
}
