//
//  ApplyProduct.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import Foundation

// 응모
struct ApplyProduct: Productable, Identifiable, Codable {

    
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

#if DEBUG
extension ApplyProduct {
    static func dummyData() -> [ApplyProduct] {
        let product1 = ApplyProduct(
            id: "1",
            productName: "Product 1",
            productImageURLStrings: ["image1", "image2", "image3"],
            description: "This is the description for Product 1",
            influencerID: "influencer1",
            winningUserID: "user1",
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400), // 1 day from now
            applyUserIDs: ["user2", "user3"],
            winningPrice: 100
        )
        
        let product2 = ApplyProduct(
            id: "2",
            productName: "Product 2",
            productImageURLStrings: ["image4", "image5"],
            description: "This is the description for Product 2",
            influencerID: "influencer2",
            winningUserID: nil,
            startDate: Date().addingTimeInterval(86400), // 1 day from now
            endDate: Date().addingTimeInterval(172800), // 2 days from now
            applyUserIDs: ["user1", "user3"],
            winningPrice: nil
        )
        
        // You can create more dummy data as needed
        
        return [product1, product2]
    }
}
#endif
