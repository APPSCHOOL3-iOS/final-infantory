import Foundation
import Firebase

class AuctionViewModel: ObservableObject {
    private var dbRef: DatabaseReference!
    
    @Published var biddingInfos: [BiddingInfo] = []
    
    init() {
        self.dbRef = Database.database().reference()
        fetchData()
    }
    
    func fetchData() {   dbRef.child("biddingInfos/1").observe(.value, with: { snapshot in
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
//        print(parsedBiddingInfos)
            
            // 파싱된 데이터로 모델 업데이트
            self.biddingInfos = parsedBiddingInfos
//            print(self.biddingInfos)
            // 필요하다면 UI 업데이트를 위해 추가적인 로직을 여기에 추가할 수 있습니다.
        })
    }
    
    func addBid(forAuction auctionId: String, biddingInfo: BiddingInfo) {
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
}

struct Auction {
    var biddingInfos: [BiddingInfo]
    var bidIncrement: Int
    
}

struct BiddingInfo {
    var id: UUID
    var timeStamp: Date
    var participants: String
    var biddingPrice: Int
}


