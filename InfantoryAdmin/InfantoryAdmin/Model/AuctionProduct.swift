//
//  AuctionProduct.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/21/23.
//

import Foundation
import FirebaseFirestoreSwift

struct AuctionProduct: Identifiable, Codable {
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

enum AuctionFilter: String, CaseIterable {
    case inProgress = "진행 경매"
    case planned = "예정 경매"
    case close = "종료 경매"
}

enum AuctionInprogressFilter: String, CaseIterable {
    case deadline = "마감순"
    case highPrice = "가격순"
}
