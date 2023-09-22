//
//  Product.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/21.
//

import Foundation

struct AuctionProduct {
    
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
    
    // 시작가, 최고가, 낙찰가
    var minPrice: Int
    var maxPrice: Int
    var winningPrice: Int
}
