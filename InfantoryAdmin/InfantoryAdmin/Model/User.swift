//
//  User.swift
//  InfantoryAdmin
//
//  Created by 김성훈 on 2023/10/20.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var isInfluencer: UserType = .user
    var nickName: String = ""
    var phoneNumber: String = ""
}

enum UserType: String, Codable, CaseIterable {
    case user
    case influencer
    
    var asKorean: String {
        switch self {
        case .user:
            return "유저"
        case .influencer:
            return "인플루언서"
        }
    }
}

