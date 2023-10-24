//
//  ActivityStore.swift
//  Infantory
//
//  Created by 이희찬 on 10/12/23.
//

import SwiftUI
import Firebase

struct ActivityStore {
    
    var loginStore: LoginStore
    let database = Firestore.firestore()
    
    func getMyAuctionInfos() async -> [AuctionActivityData] {
        let products: [AuctionProduct] = await fetchAuctionProducts()
        try? await loginStore.fetchUser(userUID: loginStore.userUid)
        return loginStore.currentUser.auctionActivityInfos?.flatMap { info in
            products.filter { $0.id == info.productId }.map { product in
                AuctionActivityData(
                    product: product,
                    myPrice: info.price,
                    timeStamp: info.timestamp
                )
            }
        } ?? []
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
        
        return loginStore.currentUser.applyActivityInfos?.flatMap { info in
            products.filter { $0.id == info.productId }.map { product in
                ApplyActivityData(
                    product: product,
                    myApplyCount: info.ticketCount,
                    timeStamp: info.timestamp
                )
            }
        } ?? []
        
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
    let timeStamp: Double
}

struct ApplyActivityData {
    let product: ApplyProduct
    let myApplyCount: Int
    let timeStamp: Double
}
