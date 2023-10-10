import Foundation
import Firebase
import Combine

class AuctionStore: ObservableObject {
    @Published var product: AuctionProduct
    @Published var biddingInfos: [BiddingInfo] = []
    
    var increment: Int = 0
    
    private var dbRef: DatabaseReference!
    
    private let firestore = Firestore.firestore().collection("AuctionProducts")
    
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
    }
    
    func updateWinningPrice(winningPrice: Int) {
        guard let productId = product.id else { return }
        
        firestore.document(productId).updateData([
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
