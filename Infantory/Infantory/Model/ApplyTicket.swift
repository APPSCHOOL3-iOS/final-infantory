//
//  ApplyTicket.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/22.
//

import Foundation
import FirebaseFirestoreSwift

struct ApplyTicket: Identifiable, Codable {
    @DocumentID var id: String?
    var date: Date
    var ticketGetAndUse: String
    var count: Int
}
