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
    
    @MainActor
    func fetchInfluencer(influencerID: String) async throws {
        influencer = User()
        let query = try await Firestore.firestore().collection("Users").document(influencerID).getDocument()
        influencer = try query.data(as: User.self)
    }
}
