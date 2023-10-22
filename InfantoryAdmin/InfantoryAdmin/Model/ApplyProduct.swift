//
//  ApplyLotteryModel.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import Foundation
import FirebaseFirestoreSwift

struct ApplyProduct: Identifiable, Codable {
    
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
    
    var dateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd E a h:mm"
        formatter.locale = Locale(identifier: "ko_kr") // 한국 시간 지정
        formatter.timeZone = TimeZone(abbreviation: "KST") // 한국 시간대 지정
        return formatter.string(from: raffleDate ?? Date())
    }
    
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


enum ApplyFilter: String, CaseIterable {
    case inProgress = "진행 응모"
    case planned = "예정 응모"
    case close = "종료 응모"
}

enum ApplyInprogressFilter: String, CaseIterable {
    case deadline = "마감순"
    case popular = "인기순"
}

enum ApplyCloseFilter: String, CaseIterable {
    case beforeRaffle = "추첨중"
    case afterRaffle = "추첨완료"
}
