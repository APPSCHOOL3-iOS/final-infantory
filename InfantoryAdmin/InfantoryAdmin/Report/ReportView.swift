//
//  ReportView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

struct ReportView: View {
    
    @StateObject private var reportStore: ReportStore = ReportStore()
    @State private var reportProductType: ReportProductType = .auction
    @State private var isShowToastMessage: Bool = false
    var body: some View {
        VStack {
            ReportTabBarView(reportStore: reportStore, reportProductType: $reportProductType)
            TabView(selection: $reportProductType) {
                ForEach(ApplyCloseFilter.allCases, id: \.self) { category in
                    switch reportProductType {
                    case .auction:
                        ScrollView {
                            VStack {
                                if reportStore.reportAuctionList.isEmpty {
                                    Spacer()
                                    Text("신고된 경매상품이 없습니다.")
                                    Spacer()
                                } else {
                                
                                    ForEach(reportStore.reportAuctionList) { product in
                                        ReportAuctionListCellView(reportStore: reportStore, product: product)
                                    }
                                }
                            }
                        }.tag(category)
                    case .apply:
                        ScrollView {
                            VStack {
                                if reportStore.reportApplyList.isEmpty {
                                    Spacer()
                                    Text("신고된 응모상품이 없습니다.")
                                    Spacer()
                                } else {
                                    ForEach(reportStore.reportApplyList) { product in
                                        ReportApplyListCellView(reportStore: reportStore, product: product)
                                    }
                                }
                    
                            }
                        }.tag(category)
                    }
                }
            }
        }
        .refreshable {
            try? await reportStore.fetchReport()
        }
        .task {
            try? await reportStore.fetchReport()
        }
    }
}

