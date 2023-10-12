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
    
    func fetchAuctionProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("AuctionProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
        
        DispatchQueue.main.async {
            self.auctionProduct = products
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
