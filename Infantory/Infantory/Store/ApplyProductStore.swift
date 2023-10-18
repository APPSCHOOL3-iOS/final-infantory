//
//  AuctionProductViewModel.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ApplyProductStore: ObservableObject {
    
    @Published var applyProduct: [ApplyProduct] = []
    @Published var selectedFilter: ApplyFilter = .inProgress
    @Published var filteredProduct: [ApplyProduct] = []
    @Published var progressSelectedFilter: ApplyInprogressFilter = .deadline
    
    func remainingTime(product: ApplyProduct) -> Double {
        return product.endDate.timeIntervalSince(Date())
    }
    
    func startTime(product: ApplyProduct) -> Double {
        return product.startDate.timeIntervalSince(Date())
    }
    //현재 유저 패치작업
    @MainActor
    func fetchApplyProducts() async throws {
        let snapshot = try await Firestore.firestore().collection("ApplyProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: ApplyProduct.self) }
        
        self.applyProduct = products
        fetchInfluencerProfile(products: products)
    }
    
    @MainActor
    func fetchInfluencerProfile(products: [ApplyProduct]) {
        for product in products {
            let documentReference = Firestore.firestore().collection("Users").document(product.influencerID)
            documentReference.getDocument { (document, _ ) in
                if let document = document, document.exists {
                    let influencerProfile = document.data()?["profileImageURLString"] as? String? ?? nil
                    if let index = self.applyProduct.firstIndex(where: { $0.id == product.id}) {
                        self.applyProduct[index].influencerProfile = influencerProfile
                        self.updateFilter(filter: self.selectedFilter)
                    }
                }
                
            }
        }
    }
    
    func updateFilter(filter: ApplyFilter) {
        switch filter {
        case .inProgress:
            selectedFilter = .inProgress
            filteredProduct = applyProduct.filter {
                $0.applyFilter == .inProgress
            }
            sortInProgressProduct(filter: progressSelectedFilter)
        case .planned:
            selectedFilter = .planned
            filteredProduct = applyProduct.filter {
                $0.applyFilter == .planned
            }
        case .close:
            selectedFilter = .close
            filteredProduct = applyProduct.filter {
                $0.applyFilter == .close
            }
        }
    }
    
    func sortInProgressProduct(filter: ApplyInprogressFilter) {
        switch filter {
        case .popular:
            filteredProduct.sort {
                $0.applyUserIDs.count > $1.applyUserIDs.count
            }
        case .deadline:
            filteredProduct.sort {
                $0.endRemainingTime < $1.endRemainingTime
            }
        }
    }
    
    func addApplyTicketUserId(ticketCount: Int,
                              product: ApplyProduct,
                              userID: String,
                              userUID: String) {
        
        let documentReference = Firestore.firestore().collection("ApplyProducts").document(product.id ?? "id 없음")
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                // 문서가 존재하는 경우, 현재 배열 필드 값을 가져옵니다.
                var currentArray = document.data()?["applyUserIDs"] as? [String] ?? []
                // 새 값을 배열에 추가하고 중복된 값도 허용합니다.
                for _ in 1 ... ticketCount {
                    currentArray.append(userID)
                }
                
                // 업데이트된 배열을 Firestore에 다시 업데이트합니다.
                documentReference.updateData(["applyUserIDs": currentArray]) { (error) in
                    if error != nil {
#if DEBUG
                        print("Error updating document: (error)")
#endif
                    } else {
#if DEBUG
                        print("Document successfully updated")
#endif
                        Task {
                            try await self.addApplyofUser(ticketCount: ticketCount,
                                                          product: product,
                                                          userUID: userUID,
                                                          database: documentReference)
                        }
                    }
                }
                
                let applyActivityInfo = ApplyActivityInfo(productId: product.id ?? "",
                                                          ticketCount: product.applyUserIDs.filter {
                    print("\($0)----- \(userID)   ")
                    print($0 == userID)
                    return $0 == userID
                }.count,
                                                          timestamp: Date().timeIntervalSince1970)
                self.updateAuctionActivityInfo(applyActivityInfo: applyActivityInfo)
            } else {
#if DEBUG
                print("Document does not exist")
#endif
            }
        }
    }
    
    func updateAuctionActivityInfo(applyActivityInfo: ApplyActivityInfo) {
        let userUID = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("Users").document(userUID).getDocument { document, error in
            if let error = error {
                print("DEBUG: applyActivityInfo fetch Error: \(error)")
            }
            do {
                var applyActivityInfos = try document?.data(as: User.self).applyActivityInfos
                applyActivityInfos?.append(applyActivityInfo)
                let dicApplyActivityInfos = try? applyActivityInfos?.map { try $0.asDictionary() }
                Firestore.firestore().collection("Users").document(userUID).updateData(["applyActivityInfos": dicApplyActivityInfos ?? []])
            } catch {
                print("DEBUG: format fail")
            }
        }
    }
    
    func addApplyofUser(ticketCount: Int,
                        product: ApplyProduct,
                        userUID: String,
                        database: DocumentReference) async throws {
        let applyDocument = try await database.getDocument()
        let product = try applyDocument.data(as: ApplyProduct.self)
        let applyTicket = ApplyTicket(date: Date(),
                                      ticketGetAndUse: "\(product.productName) 응모",
                                      count: -ticketCount)
        _ = try Firestore
            .firestore()
            .collection("Users")
            .document(userUID)
            .collection("ApplyTickets")
            .addDocument(from: applyTicket)
    }
    
    @MainActor
    func fetchSearchApplyProduct(keyword: String) async throws {
        let snapshot = try await Firestore.firestore().collection("ApplyProducts").getDocuments()
        let products = snapshot.documents.compactMap { try? $0.data(as: ApplyProduct.self) }
        
        self.applyProduct = products
        fetchInfluencerProfile(products: products)
        applyProduct = applyProduct.filter { product in
            product.productName.localizedCaseInsensitiveContains(keyword)
        }
        applyProduct.sort {
            $0.endRemainingTime > $1.endRemainingTime
        }
    }
    
    func findSearchKeyword(keyword: String) {
        Task {
            try await fetchSearchApplyProduct(keyword: keyword)
        }
    }
}
