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
    
    //현재 유저 패치작업
    
    @MainActor
    func fetchAuctionProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("AuctionProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: AuctionProduct.self) }
        
        self.auctionProduct = products
        try await fetchData(products: products)
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
            //            documentReference.getDocument { (document, _ ) in
            //                if let document = document, document.exists {
            //                    let influencerProfile = document.data()?["profileImageURLString"] as? String? ?? nil
            //                    if let index = self.auctionProduct.firstIndex(where: { $0.id == product.id}) {
            //                        self.auctionProduct[index].influencerProfile = influencerProfile
            //                        self.updateFilter(filter: self.selectedFilter)
            //                    }
            //                } else {
            //#if DEBUG
            //                    print("인플루언서 프로필이 없습니다")
            //#endif
            //                }
            //
            //            }
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
    
    func fetchData(products: [AuctionProduct]) async throws {
        for product in products {
            guard let productId = product.id else { return }
            let dbRef = Database.database().reference()
            dbRef.child("biddingInfos/\(productId)")
                .queryOrdered(byChild: "timeStamp")
                .observe(.value, with: { snapshot in
                    var parsedBiddingInfos: [BiddingInfo] = []
                    for child in snapshot.children {
                        if let childSnapshot = child as? DataSnapshot,
                           let bidData = childSnapshot.value as? [String: Any],
                           let userID = bidData["userID"] as? String,
                           let userNickname = bidData["userNickname"] as? String,
                           let biddingPrice = bidData["biddingPrice"] as? Int,
                           let timeStamp = (bidData["timeStamp"] as? Double).map({ Date(timeIntervalSince1970: $0) }) {
                            
                            let biddingInfo = BiddingInfo(
                                id: UUID(uuidString: childSnapshot.key) ?? UUID(),
                                timeStamp: timeStamp,
                                userID: userID,
                                userNickname: userNickname,
                                biddingPrice: biddingPrice
                            )
                            parsedBiddingInfos.append(biddingInfo)
                        }
                    }
                    if let index = self.auctionProduct.firstIndex(where: { $0.id == product.id}) {
                        self.auctionProduct[index].biddingInfo = parsedBiddingInfos
                    }
                })
        }
    }
    
    func sortFilteredProduct() {
        filteredProduct = filteredProduct.sorted {
            $0.biddingInfo?.count ?? 0 > $1.biddingInfo?.count ?? 0
        }
    }
}
