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
    
    @MainActor
    func fetchInfluencer(influencerID: String) async throws {
        influencer = User()
        let query = try await Firestore.firestore().collection("Users").document(influencerID).getDocument()
        influencer = try query.data(as: User.self)
    }
}

enum InfluencerCategory: String, CaseIterable {
    case auction = "경매"
    case apply = "응모"
}
