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

final class ApplyProductViewModel: ObservableObject {
    
    @Published var applyProduct: [ApplyProduct] = []

    //현재 유저 패치작업
    @MainActor
    func fetchApplyProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("ApplyProducts").getDocuments()
        print("\(snapshot)")
        let products = snapshot.documents.compactMap { try? $0.data(as: ApplyProduct.self) }
        
        self.applyProduct = products
    }
    
    @MainActor
    func createAuctionProduct(title: String,
                              apply: String,
                              itemDescription: String,
                              winningPrice: String)
    async throws {
        do {
            let product = makeAuctionModel(title: title, apply: apply, itemDescription: itemDescription, winningPrice: winningPrice)
            try Firestore.firestore().collection("ApplyProducts").addDocument(from: product)
        } catch {print(String(describing: error))
            print("debug : Failed to Create User with \(error.localizedDescription)")
        }
    }
    private func makeAuctionModel(title: String,
                                  apply: String,
                                  itemDescription: String,
                                  winningPrice: String) -> ApplyProduct {
        
        let product = ApplyProduct(id: "", productName: title, productImageURLStrings: [], description: itemDescription, influencerID: "", influencerNickname: "", startDate: Date(), endDate: Date(), applyUserIDs: [])
        return product
    }
    
    func addApplyTicketUserId(ticketCount: Int, product: ApplyProduct, userID: String) {
        
        var tempArray: [String] = []
        
        for _ in 1...ticketCount {
            tempArray.append(userID)
        }
        Firestore.firestore().collection("ApplyProducts").document(product.id ?? "(ID 없음)")
            .setData(["applyUserIDs": tempArray], merge: true)
//        Task {
//           try await self.fetchApplyProducts()
//        }
    }
    
    func reduceApplyTicket() {
        
    }
}
