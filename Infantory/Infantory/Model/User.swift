//
//  User.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/21.
//

import Foundation

struct User: Identifiable {
    var id: String
    var isInfluencer: UserType = .user // influencer인지 일반 User인지?
    var profileImageURLString: String?
    var name: String
    var phoneNumber: String
    var email: String
    var birthDate: String
    
    var loginType: LoginType
    var address: Address
    var paymentInfos: [PaymentInfo]
    
    var follower: [String]? = nil
    var applyTicket: [ApplyTicket]
    var influencerIntroduce: String?
}

// 상세주소
struct Address {
    var fullAddress: String
}

// 소셜로그인 타입
enum LoginType: String {
    case kakao
    case apple
    
}

enum UserType: String, Codable {
    case user
    case influencer
}

enum PaymentMethod: String, CaseIterable {
    case card
    case accountTransfer
    case naverPay
    case kakaoPay
    case tossPay
}
