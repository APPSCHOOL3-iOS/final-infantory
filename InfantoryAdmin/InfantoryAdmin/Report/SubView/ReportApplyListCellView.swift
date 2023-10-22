//
//  ReportListCellView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import SwiftUI

struct ReportApplyListCellView: View {
    
    @ObservedObject var reportStore: ReportStore
    var product: ApplyProduct
    @State private var isShowReportDetailSheet: Bool = false
    var reportCount: Int {
        let filteredproducts = reportStore.groupApplies.filter { apply in
            apply.reportProductID == product.id
        }
        
        var countArray: [String] = []
        for filteredproduct in filteredproducts {
            countArray = filteredproduct.reporters
        }
        return countArray.count
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("\(product.influencerNickname)")
                    .font(.title2.bold())
                Spacer()
                Text("신고 횟수 \(reportCount)회")
                    .font(.headline.bold())
            }
            HStack(spacing: 16) {
                if product.productImageURLStrings.count > 0 {
                    AsyncImage(url: URL(string: product.productImageURLStrings[0])) { image in
                        if product.applyFilter == .close {
                            
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius: 5)
                                    .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                    .clipped()
                                    .cornerRadius(10)
                            
                                if product.applyCloseFilter == .beforeRaffle {
                                    Text("추첨 중")
                                        .padding(10)
                                        .bold()
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .cornerRadius(20)
                                } else  {
                                    Text("추첨 종료")
                                        .padding(10)
                                        .bold()
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .cornerRadius(20)
                                }
                            }
                        } else if product.applyFilter == .planned {
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius: 5)
                                    .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                Text("응모 예정")
                                    .padding(10)
                                    .bold()
                                    .foregroundColor(.white)
                                    .background(Color.orange)
                                    .cornerRadius(20)
                            }
                        } else {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                .clipped()
                                .cornerRadius(10)
                        }
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("\(product.productName)")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        HStack {
                            
                            if product.applyFilter != .planned {
                                Text("전체 응모: \(product.applyUserIDs.count) 회")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        
                        Button {
                            isShowReportDetailSheet = true
                        } label: {
                            Text("신고 상세보기")
                        }
                        .buttonStyle(.bordered)
                        
                        
                    }
                    Spacer()
                }

            }
        }
        .padding()
        .sheet(isPresented: $isShowReportDetailSheet, content: {
            ReportApplyDetailSheetView(reportStore: reportStore, product: product)
        })
    }
}
