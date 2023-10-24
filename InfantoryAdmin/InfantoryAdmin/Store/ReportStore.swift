//
//  ReportStore.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

final class ReportStore: ObservableObject {
    
    @Published var selectedCatogory: ReportProductType = .auction
    @Published var reportAuctionList: [AuctionProduct] = []
    @Published var reportApplyList: [ApplyProduct] = []
    @Published var groupApplies: [GroupedReport] = []
    @Published var groupAuctions: [GroupedReport] = []
    
    func fetchReport() async throws {
        let snapshot = try await Firestore.firestore().collection("Report").getDocuments()
        let reports = snapshot.documents.compactMap { try? $0.data(as: Report.self) }
        
        let applyReports = reports.filter { report in
            report.reportProductType == "ApplyProducts"
        }
        let auctionReports = reports.filter { report in
            report.reportProductType == "AuctionProducts"
        }
        try await groupApplyReport(applyReports: applyReports)
        try await groupAuctionReport(auctionReports: auctionReports)
    }
    
    
    
    @MainActor
    func groupApplyReport(applyReports: [Report]) async throws {
        self.groupApplies = []
        for applyReport in applyReports {
            if let index = groupApplies.firstIndex(where: { $0.reportProductID == applyReport.reportProductID }) {
                    // 이미 그룹화된 데이터가 있으면 추가
                
                    self.groupApplies[index].id.append(applyReport.id ?? "")
                    self.groupApplies[index].reasons.append(applyReport.reportReason)
                    self.groupApplies[index].dates.append(applyReport.dateToString)
                    self.groupApplies[index].reporters.append(applyReport.reporterID)
                
                } else {
                    // 새로운 그룹 생성
                    let newGroup = GroupedReport(
                        id: [applyReport.id ?? ""],
                        reportProductType: applyReport.reportProductType,
                        reportProductID: applyReport.reportProductID,
                        reasons: [applyReport.reportReason],
                        dates: [applyReport.dateToString],
                        reporters: [applyReport.reporterID]
                    )
                    
                        self.groupApplies.append(newGroup)
                    
                }
        }
        Task {
            try await fetchApplyReport()
        }
    }
    
    func fetchApplyReport() async throws {
        DispatchQueue.main.async {
            self.reportApplyList = []
        }
        for groupApply in groupApplies {
            let documentReference = Firestore.firestore().collection("ApplyProducts").document(groupApply.reportProductID)
            let applyProduct = try await documentReference.getDocument(as: ApplyProduct.self)
            DispatchQueue.main.async {
                self.reportApplyList.append(applyProduct)
                print("\(self.reportApplyList)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @MainActor
    func groupAuctionReport(auctionReports: [Report]) async throws {
        self.groupAuctions = []
        for auctionReport in auctionReports {
            if let index = groupAuctions.firstIndex(where: { $0.reportProductID == auctionReport.reportProductID }) {
                    // 이미 그룹화된 데이터가 있으면 추가
                
                    self.groupAuctions[index].id.append(auctionReport.id ?? "")
                    self.groupAuctions[index].reasons.append(auctionReport.reportReason)
                    self.groupAuctions[index].dates.append(auctionReport.dateToString)
                    self.groupAuctions[index].reporters.append(auctionReport.reporterID)
                
                } else {
                    // 새로운 그룹 생성
                    let newGroup = GroupedReport(
                        id: [auctionReport.id ?? ""],
                        reportProductType: auctionReport.reportProductType,
                        reportProductID: auctionReport.reportProductID,
                        reasons: [auctionReport.reportReason],
                        dates: [auctionReport.dateToString],
                        reporters: [auctionReport.reporterID]
                    )
                    
                        self.groupAuctions.append(newGroup)
                    
                }
        }
        Task {
            try await fetchAuctionReport()
        }
    }
    
    
    
    
    func fetchAuctionReport() async throws {
        DispatchQueue.main.async {
            self.reportAuctionList = []
        }
        for groupAuction in groupAuctions {
            let documentReference = Firestore.firestore().collection("AuctionProducts").document(groupAuction.reportProductID)
            var auctionProduct = try await documentReference.getDocument(as: AuctionProduct.self)
            Database.database().reference().child("biddingInfos/\(String(describing: auctionProduct.id))")
                .queryOrdered(byChild: "timeStamp")
                .observe(.value) { (snapshot) in
                    if let infos = snapshot.children.allObjects as? [DataSnapshot] {
                        if let biddingInfo = infos.last?.value as? [String: AnyObject] {
                            auctionProduct.winningPrice = Int(biddingInfo["biddingPrice"] as? Double ?? 0.0)
                        }
                    }
                }
            DispatchQueue.main.async {
                self.reportAuctionList.append(auctionProduct)
            }
        }
    }
    
    func deleteProduct(productID: String, productType: String) {
        if productType == "AuctionProducts" {
             Firestore.firestore().collection("AuctionProducts")
                .document(productID)
                .delete()
            
        } else {
             Firestore.firestore().collection("ApplyProducts")
                .document(productID)
                .delete()
        }
        Task {
            try await fetchReport()
        }
    }
}
