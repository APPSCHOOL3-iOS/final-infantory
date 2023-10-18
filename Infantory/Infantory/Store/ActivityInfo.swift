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
                    myPrice: info.price
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
                    product: product,
                    myApplyCount: info.ticketCount
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
    let myPrice: Int
}

struct ApplyActivityData {
    let product: ApplyProduct
    let myApplyCount: Int
}
