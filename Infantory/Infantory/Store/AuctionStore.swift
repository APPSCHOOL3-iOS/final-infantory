import Foundation
import Firebase
import Combine

class AuctionStore: ObservableObject {
    @Published var product: AuctionProduct = AuctionProduct.dummyProduct
    @Published var biddingInfos: [BiddingInfo] = []
    
    var increment: Int = 0
    
    private var dbRef: DatabaseReference!
    
    init() {
        self.dbRef = Database.database().reference()
        fetchData()
    }
    
    func fetchData() {
        dbRef.child("biddingInfos").observe(.value, with: { snapshot in
            var parsedBiddingInfos: [BiddingInfo] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let bidData = childSnapshot.value as? [String: Any],
                   let participants = bidData["participants"] as? String,
                   let biddingPrice = bidData["biddingPrice"] as? Int,
                   let timeStamp = (bidData["timeStamp"] as? Double).map({ Date(timeIntervalSince1970: $0) }) {
                    
                    let biddingInfo = BiddingInfo(
                        id: UUID(uuidString: childSnapshot.key) ?? UUID(),
                        timeStamp: timeStamp,
                        participants: participants,
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
        let newBidRef = dbRef.child("biddingInfos").childByAutoId()
        
        // BiddingInfo를 [String: Any] 형태로 변환
        let bidData: [String: Any] = [
            "timeStamp": biddingInfo.timeStamp.timeIntervalSince1970,
            "participants": biddingInfo.participants,
            "biddingPrice": biddingInfo.biddingPrice
        ]
        
        // 데이터 쓰기
        newBidRef.setValue(bidData)
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


