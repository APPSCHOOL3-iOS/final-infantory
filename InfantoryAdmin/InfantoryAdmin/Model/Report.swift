//
//  Report.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
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
    
    var dateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd E a h:mm"
        formatter.locale = Locale(identifier: "ko_kr") // 한국 시간 지정
        formatter.timeZone = TimeZone(abbreviation: "KST") // 한국 시간대 지정
        return formatter.string(from: reportDate)
    }
}

struct GroupedReport: Identifiable {
    var id: [String]
    var reportProductType: String
    var reportProductID: String
    var reasons: [String]
    var dates: [String]
    var reporters: [String]
}

enum ReportProductType: String, CaseIterable {
    case auction = "경매"
    case apply = "응모"
}

let reports: [Report] = [
    Report(reportProductType: "응모", reportProductID: "123", reportReason: "짜증", reportDate: Date(), reporterID: "조민근") ,
    Report(reportProductType: "응모", reportProductID: "456", reportReason: "짜증", reportDate: Date(), reporterID: "조민근") ,
    Report(reportProductType: "응모", reportProductID: "123", reportReason: "짜증", reportDate: Date(), reporterID: "안지영")
]
