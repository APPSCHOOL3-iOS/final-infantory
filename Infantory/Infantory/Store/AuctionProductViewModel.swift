//
//  AuctionProductViewModel.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/22.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AuctionProductViewModel: ObservableObject {
    @Published var auctionProduct: [AuctionProduct] = []
    @Published var selectedFilter: AuctionFilter = .inProgress
    @Published var filteredProduct: [AuctionProduct] = []
    @Published var progressSelectedFilter: AuctionInprogressFilter = .deadline
    
    @MainActor
    func fetchAuctionProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("AuctionProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
        
        self.auctionProduct = products
        self.fetchAuctionCount(products: products)
        try await fetchInfluencerProfile(products: products)
    }
    
    @MainActor
    func fetchInfluencerProfile(products: [AuctionProduct]) async throws {
        for product in products {
            let documentReference = Firestore.firestore().collection("Users").document(product.influencerID)
            let snapShot = try await documentReference.getDocument()
            let influencerProfile = snapShot.data()?["profileImageURLString"] as? String? ?? nil
            if let index = self.auctionProduct.firstIndex(where: { $0.id == product.id}) {
                self.auctionProduct[index].influencerProfile = influencerProfile
                self.updateFilter(filter: self.selectedFilter)
            }
        }
    }
    
    func fetchAuctionCount(products: [AuctionProduct]) {
        for product in products {
            let dbRef = Database.database().reference()
            dbRef.child("biddingInfos/\(product.id ?? "")")
                .queryOrdered(byChild: "timeStamp")
                .observe(.value, with: { snapshot in
                    if let index = self.auctionProduct.firstIndex(where: { $0.id == product.id}) {
                        self.auctionProduct[index].count = Int(snapshot.childrenCount)
                }
            })
        }
    }
    
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
        
        self.auctionProduct = products
        try await fetchInfluencerProfile(products: products)
        auctionProduct = auctionProduct.filter { product in
            product.productName.localizedCaseInsensitiveContains(keyword)
        }
        auctionProduct.sort {
            $0.endRemainingTime > $1.endRemainingTime
        }
    }
    
    func findSearchKeyword(keyword: String) {
        Task {
            try await fetchSearchActionProduct(keyword: keyword)
        }
    }
    
    func sortFilteredProduct() {
        filteredProduct = filteredProduct.sorted {
            $0.count ?? 0 > $1.count ?? 0
        }
    }
}
