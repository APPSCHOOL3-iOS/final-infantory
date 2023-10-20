//
//  InfluencerManageStore.swift
//  InfantoryAdmin
//
//  Created by 김성훈 on 2023/10/20.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

final class InfluencerManageStore: ObservableObject {
    @Published var selectedCategory: UserType = .user
    @Published var users: [User] = []
    
    private let dbRef = Firestore.firestore().collection("Users")
    
    @MainActor func updateUsers(_ users: [User]) {
        self.users = users
    }
    
    func fetchUsers(type: UserType) async throws {
        let snapshot = try await dbRef.whereField("isInfluencer", isEqualTo: type.rawValue).getDocuments()
        
        var users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        
        await updateUsers(users)
    }
    
    func updateUserToInfluencer(userId: String) async throws {
        try? await dbRef.document(userId).updateData(["isInfluencer": UserType.influencer.rawValue])
        try? await fetchUsers(type: selectedCategory)
    }
    

    
//    func sortByUserType(type: UserType) {
//
//    }
}
