//
//  User.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
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

// 샘플 데이터
#if DEBUG
extension User {
    static let sampleData: Self = User(id: "1234", isInfluencer: UserType.user, profileImageURLString: "", name: "주헌", phoneNumber: "01043255324", email: "fndso@naver.com", birthDate: "990727", loginType: LoginType.kakao, address: Address(), paymentInfos: [], applyCount: 5, influencerIntroduce: "")
    static let sampleData2: Self = User(id: "1234", isInfluencer: UserType.user, profileImageURLString: "", name: "주헌", phoneNumber: "01043255324", email: "fndso@naver.com", birthDate: "990727", loginType: LoginType.kakao, address: Address(), paymentInfos: [], applyCount: 5, influencerIntroduce: "")
    static let sampleData3: Self = User(id: "1234", isInfluencer: UserType.user, profileImageURLString: "", name: "주헌", phoneNumber: "01043255324", email: "fndso@naver.com", birthDate: "990727", loginType: LoginType.kakao, address: Address(), paymentInfos: [], applyCount: 5, influencerIntroduce: "")
}
#endif
