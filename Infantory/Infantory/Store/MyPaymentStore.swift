//
//  MyPaymentStore.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/18.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

final class MyPaymentStore: ObservableObject {
    @Published private(set) var myPayments: [PaymentInfo] = []
    
    private let database = Firestore.firestore().collection("paymentInfos")
    
    @MainActor
    func updateMyPayments(payments: [PaymentInfo]) {
        self.myPayments = payments
    }
    
    func fetchMyPayments(userId: String) async throws {
        let snapshot = try await database.whereField("userId", isEqualTo: userId).getDocuments()
        let infos = snapshot.documents.compactMap { try? $0.data(as: PaymentInfo.self)}
        let filteredInfos = self.filterIsPaidProduct(infos)
        
        await updateMyPayments(payments: filteredInfos)
    }
    
    private func filterIsPaidProduct(_ payments: [PaymentInfo]) -> [PaymentInfo] {
        let isPaidProductsInfos = payments.filter {
            // 옵셔널을 풀기
            if let product = $0.applyProduct {
                if product.isPaid == true {
                    return true
                }
            }
            
            if let product = $0.auctionProduct {
                if product.isPaid == true {
                    return true
                }
            }
            
            return false
        }
        
        return isPaidProductsInfos
    }
}
