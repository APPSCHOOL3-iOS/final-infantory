//
//  AuctionProduct.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import Foundation
import FirebaseFirestoreSwift

struct AuctionProduct: Productable, Identifiable, Codable {
    @DocumentID var id: String?
    var productName: String
    var productImageURLStrings: [String]
    var description: String
    
    // 인플루언서 누구인지, 낙찰자
    var influencerID: String
    var influencerNickname: String
    var influencerProfile: String? = nil
    var winningUserID: String?
    
    // 응모 시작일, 마감일
    var startDate: Date
    var endDate: Date
    var registerDate: Date
    var startRemainingTime: Double {
        return startDate.timeIntervalSince(Date())
    }
    var endRemainingTime: Double {
        return endDate.timeIntervalSince(Date())
    }
    
    // 시작가, 최고가, 낙찰가
    var minPrice: Int
    var winningPrice: Int?
    
    var isPaid: Bool = false
    
    var auctionFilter: AuctionFilter {
        if startRemainingTime > 0.0 {
            return .planned
        } else if startRemainingTime < 0.0 && endRemainingTime > 0.0 {
            return .inProgress
        } else if endRemainingTime < 0.0 {
            return .close
        }
        return .planned
    }
    
    var count: Int? = nil
}

#if DEBUG
extension AuctionProduct {
    static let dummyProduct = AuctionProduct(
        id: "1",
        productName: "Example Product",
        productImageURLStrings: ["https://dimg.donga.com/wps/NEWS/IMAGE/2021/12/11/110733453.1.jpg"],
        description: "This is an example product for auction.",
        influencerID: "상필갓",
        influencerNickname: "상필임당",
        winningUserID: nil, // 낙찰자가 아직 없는 경우 nil로 설정
        startDate: Date(), // 현재 날짜로 설정
        endDate: Date().addingTimeInterval(24 * 60 * 60), // 현재 날짜로부터 7일 후로 설정
        registerDate: Date(), minPrice: 100, // 시작가
        winningPrice: 100000 // 낙찰가는 아직 결정되지 않았으므로 0으로 설정
    )
}
#endif
