//
//  BiddingInfo.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/09.
//

import Foundation
import FirebaseFirestoreSwift
 
struct BiddingInfo: Codable, Hashable {
    var id: UUID
    var timeStamp: Date
    var userID: String
    var userNickname: String
    var biddingPrice: Int
}
