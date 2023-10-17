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
}

/* 응모 가져올때 가정
 
 1. User 안에 applyProductsIDs 안에 있는 상품 아이디로 상품을 가져온다
 2. 상품에 접근을해서 applyInfoIDs 에 접근
 3. applyInfoIDs를 통해 WhereField를 써서 자신이 한것들 가져오기
 4. 가져온 나의 배열을 통해 보여주면 됨
 
 
 응모를 할 때 가정
 1. ApplyInfo를 테이블에 추가
 2. Product에 applyInfoIDs를 업데이트
 3. User에 applyProductsIDs배열에 ProductId를 추가
 */
