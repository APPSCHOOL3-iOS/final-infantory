//
//  User.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var isInfluencer: UserType = .user
    var profileImageURLString: String? = nil
    var name: String = ""
    var nickName: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var loginType: LoginType = .kakao
    var address: Address = Address(address: "", zonecode: "", addressDetail: "")
    
    var follower: [String]? = nil
    var influencerIntroduce: String? = nil
    
    var auctionActivityInfos: [AuctionActivityInfo]? = nil
    var applyActivityInfos: [ApplyActivityInfo]? = nil
}

struct AuctionActivityInfo: Codable {
    var productId: String
    var price: Int
    var timestamp: Double
}

struct ApplyActivityInfo: Codable {
    var productId: String
    var ticketCount: Int
    var timestamp: Double
}

// 주소
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
