//
//  AuctionProductViewModel.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AuctionProductViewModel: ObservableObject {
    @Published var auctionProduct: [AuctionProduct] = []
    
    //현재 유저 패치작업
    @MainActor
    func fetchAuctionProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("AuctionProducts").getDocuments()
        print("\(snapshot)")
        let products = snapshot.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
        
        self.auctionProduct = products
        
    }
    
    @MainActor
    func createAuctionProduct(title: String,
                              apply: String,
                              itemDescription: String,
                              startingPrice: String,
                              maximumPrice: String) async throws {
        do {
            let product = makeAuctionModel(title: title, apply: apply, itemDescription: itemDescription, startingPrice: startingPrice, maximumPrice: maximumPrice)
            try Firestore.firestore().collection("AuctionProducts").addDocument(from: product)
        } catch {print(String(describing: error))
            print("debug : Failed to Create User with \(error.localizedDescription)")
        }
    }
    private func makeAuctionModel(title: String,
                                  apply: String,
                                  itemDescription: String,
                                  startingPrice: String,
                                  maximumPrice: String) -> AuctionProduct {
        
        let product = AuctionProduct(id: "user", productName: title, productImageURLStrings: [], description: itemDescription, influencerID: "IU", startDate: Date(), endDate: Date(), minPrice: 10000, maxPrice: 100000, winningPrice: 50000)
        return product
    }
}

