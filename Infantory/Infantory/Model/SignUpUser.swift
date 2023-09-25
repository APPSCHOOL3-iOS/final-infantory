//
//  SignUp.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/22.
//

import Foundation

struct SignUpUser: Identifiable {
    var id: String // 이메일
    var isInfluencer: UserType = .user // influencer인지 일반 User인지?
    var profileImageURLString: String?
    var name: String
    var phoneNumber: String
    var loginType: LoginType
    var address: Address
    var follower: [String]? = nil
    var applyTicket: [ApplyTicket]
    var influencerIntroduce: String?
    var password: String
}
