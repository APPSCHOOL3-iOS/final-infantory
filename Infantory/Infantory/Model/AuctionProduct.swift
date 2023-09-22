//
//  AuctionProduct.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import Foundation

struct AuctionProduct: Productable, Identifiable {
    
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

#if DEBUG
extension AuctionProduct {
    static let sampleData: Self = AuctionProduct(id: "1234", productName: "나이키 조던", productImageURLStrings: ["Shose1"], description: "이 신발 신으면 하늘 날아감", influencerID: "123", startDate: Date().addingTimeInterval(86400 * 7), endDate: Date().addingTimeInterval(86400 * 7), minPrice: 40000, maxPrice: 1000000, winningPrice: 50000)
}
#endif