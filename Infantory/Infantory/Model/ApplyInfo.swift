//
//  ApplyInfo.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/09.
//

import Foundation
import FirebaseFirestoreSwift

struct ApplyInfo: Codable {
    @DocumentID var id: String?
    var timeStamp: Date
    var ticketIDs: [String]
    var userID: String
    var userNickname: String
}
