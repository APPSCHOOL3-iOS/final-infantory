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
    
    @MainActor
    func addApplyTicketUserId(ticketCount: Int, product: ApplyProduct, userID: String, userUID: String, completion: @escaping (ApplyProduct) -> Void) {
        
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
                        print("Error updating document: (error)")
                    } else {
                        print("Document successfully updated")
                        Task {
                            try await self.fetchProduct(ticketCount: ticketCount, product: product, userUID: userUID, database: documentReference) { product in
                                completion(product)
                            }
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }     
    }
    @MainActor
    func fetchProduct(ticketCount: Int, product: ApplyProduct, userUID: String, database: DocumentReference, completion: @escaping (ApplyProduct) -> Void) async throws {
        let applyDocument = try await database.getDocument()
        let product = try applyDocument.data(as: ApplyProduct.self)
        let applyTicket = ApplyTicket(date: Date(), ticketGetAndUse: "\(product.productName) 응모", count: -ticketCount)
        _ = try Firestore.firestore().collection("Users").document(userUID).collection("ApplyTickets").addDocument(from: applyTicket)
        completion(product)
    }
}
