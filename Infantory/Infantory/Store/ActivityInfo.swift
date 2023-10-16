//
//  ActivityStore.swift
//  Infantory
//
//  Created by 이희찬 on 10/12/23.
//

import Foundation
import Firebase

struct ActivityInfo {
    let auctionActivityInfos: [AuctionActivityInfo]
    let applyActivityInfos: [ApplyActivityInfo]
    
    let database = Firestore.firestore()
    
    func getMyAuctionInfos() async -> [AuctionActivityData] {
        let products: [AuctionProduct] = await fetchAuctionProducts()
        
        return auctionActivityInfos.flatMap { info in
            products.filter { $0.id == info.productId }.map { product in
                AuctionActivityData(
                    product: product,
                    price: info.price,
                    timestamp: info.timestamp
                )
            }
        }
    }
    
    func fetchAuctionProducts() async -> [AuctionProduct] {
        do {
            let documents = try await database.collection("AuctionProducts").getDocuments()
            let products = documents.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
            return products
        } catch {
            print("Error fetching products: \(error)")
            return []
        }
    }
    
    func getMyApplyInfos() async -> [ApplyActivityData] {
        let products: [ApplyProduct] = await fetchApplyProducts()
        
        return applyActivityInfos.flatMap { info in
            products.filter { $0.id == info.productId }.map { product in
                ApplyActivityData(
                    productId: product.id ?? "",
                    myApplyCount: info.ticketCount,
                    timestamp: info.timestamp,
                    totalApplyCount: product.applyUserIDs.count,
                    imageURLString: product.productImageURLStrings[0],
                    productName: product.productName,
                    remainingTime: product.endDate.timeIntervalSince(Date())
                )
            }
        }
    }
    
    func fetchApplyProducts() async -> [ApplyProduct] {
        do {
            let documents = try await database.collection("ApplyProducts").getDocuments()
            let products = documents.documents.compactMap { try? $0.data(as: ApplyProduct.self) }
            return products
        } catch {
            print("Error fetching products: \(error)")
            return []
        }
    }
    
}

struct AuctionActivityData {
    let product: AuctionProduct
    var price: Int
    var timestamp: Double
}

struct ApplyActivityData {
    var productId: String
    var myApplyCount: Int
    var timestamp: Double
    var totalApplyCount: Int
    var imageURLString: String
    var productName: String
    var remainingTime: Double
}
