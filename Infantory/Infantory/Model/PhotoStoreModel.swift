//
//  PhotoStoreModel.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

//사용자 서비스(로컬단의 세션)
class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    //현재 유저 패치작업
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("Users").document(uid).getDocument()
        //
        let user = try snapshot.data(as: User.self)
        
        self.currentUser = user
        
    }
}
