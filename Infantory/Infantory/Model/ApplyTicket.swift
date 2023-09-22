//
//  ApplyTicket.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/22.
//

import Foundation
import FirebaseFirestoreSwift

struct ApplyTicket: Identifiable {
    @DocumentID var id: String?
    var userId: String // user의 이메일값, User안으로 들어가면 documentId값으로
    var date: Date
    var ticketGetAndUse: String
    var count: Int
}
