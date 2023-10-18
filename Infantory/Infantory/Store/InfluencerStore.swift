//
//  InfluencerStore.swift
//  Infantory
//
//  Created by 민근의 mac on 10/16/23.
//

import SwiftUI
import FirebaseFirestore

final class InfluencerStore: ObservableObject {
    @Published var influencer: User = User()
    @Published var selectedCategory: InfluencerCategory = .auction
    @Published var influencerApplyProduct: [ApplyProduct] = []
    @Published var influencerAuctionProduct: [AuctionProduct] = []
    
    func fetchInfluencer(influencerID: String) async throws {
        influencer = User()
        let query = try await Firestore.firestore().collection("Users").document(influencerID).getDocument()
        DispatchQueue.main.async {
            do {
                self.influencer = try query.data(as: User.self)
            } catch {
                print("error: 인플루언서를 불러오지 못했습니다.")
            }
        }
    }
    
    func fetchInfluencerApplyProduct(influencerID: String) async throws {
        influencerApplyProduct = []
        let query = Firestore.firestore().collection("ApplyProducts").whereField("influencerID", isEqualTo: influencerID)
        let snapshot = try await query.getDocuments()
        let documents = snapshot.documents
        for document in documents {
            do {
                let influencerProduct = try document.data(as: ApplyProduct.self)
                DispatchQueue.main.async {
                    self.influencerApplyProduct.append(influencerProduct)
                }
            } catch {
                print("error: 해당 인플루언서의 응모 상품을 불러오지 못했습니다.")
            }
        }
    }
    
    func fetchInfluencerAuctionProduct(influencerID: String) async throws {
        influencerAuctionProduct = []
        let query = Firestore.firestore().collection("AuctionProducts").whereField("influencerID", isEqualTo: influencerID)
        let snapshot = try await query.getDocuments()
        let documents = snapshot.documents
        for document in documents {
            do {
                let influencerProduct = try document.data(as: AuctionProduct.self)
                DispatchQueue.main.async {
                    self.influencerAuctionProduct.append(influencerProduct)
                }
            } catch {
                print("error: 해당 인플루언서의 경매 상품을 불러오지 못했습니다.")
            }
        }
    }
}

enum InfluencerCategory: String, CaseIterable {
    case auction = "경매"
    case apply = "응모"
}
