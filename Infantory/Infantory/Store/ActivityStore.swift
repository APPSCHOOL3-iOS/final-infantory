//
//  ActivityStore.swift
//  Infantory
//
//  Created by 이희찬 on 10/12/23.
//

import Foundation
import Firebase

class ActivityStore: ObservableObject {
    @Published var auctionActivityDatas: [AuctionActivityData] = []
    @Published var applyActivityDatas: [ApplyActivityData] = []
    
    let database = Firestore.firestore()
    
    func fetchMyAuctionProducts(auctionProducts: [AuctionProduct], auctionActivityInfos: [AuctionActivityInfo]) {
        for info in auctionActivityInfos {
            for product in auctionProducts {
                if product.id == info.productId {
                    DispatchQueue.main.async {
                        self.auctionActivityDatas.append(AuctionActivityData(productId: product.id ?? "",
                                                                        price: info.price,
                                                                        timestamp: info.timestamp,
                                                                        winningPrice: product.winningPrice ?? 0,
                                                                        imageURLString: product.productImageURLStrings,
                                                                        productName: product.productName,
                                                                        remainingTime: product.endDate.timeIntervalSince(Date())))
                    }
                }
            }
        }
        print(auctionActivityDatas)
    }
    
    func fetchMyApplyProducts() {
        
    }
}

struct AuctionActivityData {
    var productId: String
    var price: Int
    var timestamp: Double
    var winningPrice: Int
    var imageURLString: [String]
    var productName: String
    var remainingTime: Double
}

struct ApplyActivityData {
    var productId: String
    var myApplyCount: Int
    var timestamp: Double
    var totalApplyCount: Int
    var imageURLString: [String]
    var productName: String
    var remainingTime: Double
}
