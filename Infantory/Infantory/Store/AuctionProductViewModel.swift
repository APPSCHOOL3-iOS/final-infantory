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
    @Published var selectedFilter: AuctionFilter = .inProgress
    @Published var filteredProduct: [AuctionProduct] = []
    @Published var progressSelectedFilter: AuctionInprogressFilter = .deadline
    
    //현재 유저 패치작업
    
    @MainActor
    func fetchAuctionProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("AuctionProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
        
        self.auctionProduct = products
        fetchInfluencerProfile(products: products)
    }
    
    @MainActor
    func fetchInfluencerProfile(products: [AuctionProduct]) {
        for product in products {
            let documentReference = Firestore.firestore().collection("Users").document(product.influencerID)
            documentReference.getDocument { (document, _ ) in
                if let document = document, document.exists {
                    let influencerProfile = document.data()?["profileImageURLString"] as? String? ?? nil
                    if let index = self.auctionProduct.firstIndex(where: { $0.id == product.id}) {
                        self.auctionProduct[index].influencerProfile = influencerProfile
                        self.updateFilter(filter: self.selectedFilter)
                    }
                } else {
#if DEBUG
                    print("인플루언서 프로필이 없습니다")
#endif
                }
                
            }
        }
    }
    
    @MainActor
    func updateFilter(filter: AuctionFilter) {
        switch filter {
        case .inProgress:
            selectedFilter = .inProgress
            filteredProduct = auctionProduct.filter {
                $0.auctionFilter == .inProgress
            }
            sortInProgressProduct(filter: progressSelectedFilter)
        case .planned:
            selectedFilter = .planned
            filteredProduct = auctionProduct.filter {
                $0.auctionFilter == .planned
            }
        case .close:
            selectedFilter = .close
            filteredProduct = auctionProduct.filter {
                $0.auctionFilter == .close
            }
        }
    }
    
    func sortInProgressProduct(filter: AuctionInprogressFilter) {
        switch filter {
        case .highPrice:
            filteredProduct.sort {
                
                $0.winningPrice ?? 10000 > $1.winningPrice ?? 100
            }
        case .deadline:
            filteredProduct.sort {
                $0.endRemainingTime < $1.endRemainingTime
            }
        }
    }
    
    @MainActor
    func fetchSearchActionProduct(keyword: String) async throws {
        let snapshot = try await Firestore.firestore().collection("AuctionProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
        
        auctionProduct = products.filter { product in
            product.productName.localizedCaseInsensitiveContains(keyword)
        }
    }
    
    @MainActor
    func findSearchKeyword(keyword: String) {
        Task {
            try await fetchSearchActionProduct(keyword: keyword)
        }
    }
}
