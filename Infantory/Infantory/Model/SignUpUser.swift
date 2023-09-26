//
//  SignUp.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/22.
//

import Foundation
import FirebaseFirestoreSwift

struct SignUpUser: Identifiable, Codable {
    @DocumentID var id: String?
    var isInfluencer: String = "user" // influencer인지 일반 User인지?
    var profileImageURLString: String? = nil
    var name: String
    var nickName: String
    var phoneNumber: String
    var email: String
    
    var loginType: String = "kakao"
    var address: String
    
    var follower: [String]? = nil
    var influencerIntroduce: String? = nil
}
