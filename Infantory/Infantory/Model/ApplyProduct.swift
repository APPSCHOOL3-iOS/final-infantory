//
//  ApplyProduct.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import Foundation

// 응모
struct ApplyProduct: Productable , Identifiable, Codable {
    
    var id: String
    var productName: String
    var productImageURLStrings: [String]
    var description: String
    
    // 인플루언서 누구인지, 낙찰자
    var influencerID: String
    var winningUserID: String?
    
    // 응모 시작일, 마감일
    var startDate: Date
    var endDate: Date
    
    // 응모한 유저
    var applyUserIDs: [String]
    
    // 지불 가격
    var winningPrice: Int?
}
