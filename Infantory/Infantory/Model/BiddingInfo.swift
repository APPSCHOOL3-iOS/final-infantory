//
//  BiddingInfo.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/09.
//

import Foundation
import FirebaseFirestoreSwift
 
struct BiddingInfo: Codable {
    var id: UUID
    var timeStamp: Date
    var userID: String
    var userNickName: String
    var biddingPrice: Int
}

/* 경매 가져올때 가정
 1. User 안에 auctionProductsIDs 안에 있는 상품 아이디로 리얼타임데이터베이스에 접근
 2. DB와 ID가 일치하는 상품의 BiddingInfos를 가져온다
 3. 자기와 같은 ID를 가지고 있는 BiddingInfo를 가져오기


 */
