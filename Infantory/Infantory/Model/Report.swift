//
//  Report.swift
//  Infantory
//
//  Created by 민근의 mac on 10/21/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Report: Identifiable, Codable {
    @DocumentID var id: String?
    var reportProductType: String
    var reportProductID: String
    var reportReason: String
    var reportDate: Date
    var reporterID: String
}
