//
//  PayProductStore.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/21/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class PayProductStore: ObservableObject {
    @Published var seletedCategory: ProductPaidFilter = .beforePaid
    @Published var applyProducts: [ApplyProduct] = []
    @Published var auctionProducts: [AuctionProduct] = []
    
    private var dbRef = Firestore.firestore()
    
    func fetchProduct() async throws {
        let applySnapshot = try await dbRef.collection("ApplyProducts").whereField("endDate", isLessThan: Date()).getDocuments()
        
        let auctionSnapshot = try await dbRef.collection("AuctionProducts").whereField("endDate", isLessThan: Date()).getDocuments()
        
        var applyProduct = applySnapshot.documents.compactMap { try? $0.data(as: ApplyProduct.self) }
        
        var auctionProduct = auctionSnapshot.documents.compactMap {
            try? $0.data(as: AuctionProduct.self)
        }
        
        applyProduct = applyProduct.filter({ product in
            product.winningUserID != nil
        })
        
        auctionProduct = auctionProduct.filter({ product in
            product.winningPrice != nil
        })
        
        
        await updateApplyProduct(applyProduct)
        await updateAuctionProduct(auctionProduct)
    }
    
    @MainActor
    private func updateApplyProduct(_ applyProduct: [ApplyProduct]) {
        self.applyProducts = applyProduct
        
    }
    
    @MainActor
    private func updateAuctionProduct(_ auctionProduct: [AuctionProduct]) {
        self.auctionProducts = auctionProduct
        
    }
}
