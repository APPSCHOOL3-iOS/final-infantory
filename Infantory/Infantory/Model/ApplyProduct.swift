//
//  ApplyProduct.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import Foundation
import FirebaseFirestoreSwift

// 응모
struct ApplyProduct: Productable, Identifiable, Codable {
    
    @DocumentID var id: String?
    var productName: String
    var productImageURLStrings: [String]
    var description: String
    
    // 인플루언서 누구인지, 낙찰자
    var influencerID: String
    var influencerNickname: String
    var influencerProfile: String? = nil
    var winningUserID: String? = nil
    
    // 응모 시작일, 마감일
    var startDate: Date
    var endDate: Date
    var registerDate: Date
    var raffleDate: Date? = nil
    var startRemainingTime: Double {
        return startDate.timeIntervalSince(Date())
    }
    var endRemainingTime: Double {
        return endDate.timeIntervalSince(Date())
    }
    var applyFilter: ApplyFilter {
        if startRemainingTime > 0.0 {
            return .planned
        } else if startRemainingTime < 0.0 && endRemainingTime > 0.0 {
            return .inProgress
        } else if endRemainingTime < 0.0 {
            return .close
        }
        
        return .planned
    }
    
    var applyCloseFilter: ApplyCloseFilter {
        if winningUserID == nil {
            return .beforeRaffle
        } else {
            return .afterRaffle
        }
    }
    
    // 응모한 유저
    var applyUserIDs: [String]
    
    // 지불 가격
    var winningPrice: Int?
    var applyInfoIDs: [String] = []
    
    var isPaid: Bool = false
}
