//
//  InfluencerStore.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import Foundation
import FirebaseFirestore

class InfluencerStore: ObservableObject {
    
    let dbRef = Firestore.firestore().collection("Users")
    @Published var userList: [User] = []
    
    
    func fetchUser() async throws {
        let snapshot = try await dbRef.getDocuments()
        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        
        DispatchQueue.main.async {
            self.userList = users
        }
        try await self.fetchUserProfile(users: users)
    }
    
    func fetchUserProfile(users: [User]) async throws {
        for user in users {
            let documentReference = dbRef.document(user.id ?? "")
            let snapshot = try await documentReference.getDocument()
            
            let userProfile = snapshot.data()?["profileImageURLString"] as? String? ?? nil
            if let index = self.userList.firstIndex(where: { $0.id == user.id}) {
                DispatchQueue.main.async {
                    self.userList[index].profileImageURLString = userProfile
                }
            }
        }
    }
    
    func userTypeChange(userID: String, isInfluencer: UserType) {
        let documentReference = dbRef.document(userID)
        documentReference.updateData(["isInfluencer": isInfluencer == .influencer ? "user" : "influencer"]) { (error) in
            if error != nil {
                
            } else {
                Task {
                    try await self.fetchUser()
                }
            }
        }
    }
}
