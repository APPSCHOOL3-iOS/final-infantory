//
//  User.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var isInfluencer: UserType // influencer인지 일반 User인지?
    var profileImageURLString: String? = nil
    var name: String
    var phoneNumber: String
    var email: String
    
    var loginType: LoginType
    var address: Address
    
    var follower: [String]? = nil
    var applyTicket: [ApplyTicket]? = nil
    var influencerIntroduce: String? = nil
    // address 바꿈, 페이먼트인포랑 벌쓰데이 뺌
}

// 상세주소
struct Address: Codable {
    var address: String
    var zonecode: String
    var addressDetail: String

}

// 소셜로그인 타입
enum LoginType: String, Codable {
    case kakao
    case apple
}

enum UserType: String, Codable {
    case user
    case influencer
}

enum PaymentMethod: String, CaseIterable, Codable {
    case card
    case accountTransfer
    case naverPay
    case kakaoPay
    case tossPay
}

#if DEBUG
extension User {
    static let dummyUser = User(
        id: "sdoYpk7SdDTcGTxgIQJy",
        isInfluencer: UserType.user,
        profileImageURLString: "https://example.com/profile/1.jpg",
        name: "상필 갓",
        phoneNumber: "123-456-7890",
        email: "john@example.com",
        loginType: LoginType.kakao,
        address: Address(address: "상필님네",
                         zonecode: "몽돌",
                         addressDetail: "해수욕장"),
        applyTicket: [
            ApplyTicket(
                id: "ticket1",
                date: Date(),
                ticketGetAndUse: "Ticket 123",
                count: 2
            ),
            ApplyTicket(
                id: "ticket2",
                date: Date(),
                ticketGetAndUse: "Ticket 456",
                count: 1
            )
        ],
        influencerIntroduce: nil
    )
}
#endif
