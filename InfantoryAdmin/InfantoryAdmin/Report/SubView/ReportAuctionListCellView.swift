//
//  ReportAuctionListCellView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

//
//  ReportListCellView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import SwiftUI

struct ReportAuctionListCellView: View {
    
    @ObservedObject var reportStore: ReportStore
    var product: AuctionProduct
    @State private var isShowReportDetailSheet: Bool = false
    var reportCount: Int {
        let filteredproducts = reportStore.groupAuctions.filter { auction in
            auction.reportProductID == product.id
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
                    .font(.title2.bold())
            }
            HStack(spacing: 16) {
                if product.productImageURLStrings.count > 0 {
                    AsyncImage(url: URL(string: product.productImageURLStrings[0])) { image in
                        if product.auctionFilter == .close {
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius: 5)
                                    .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                Text("경매 종료")
                                    .padding(10)
                                    .bold()
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(20)
                            }
                        
                        } else if product.auctionFilter == .planned {
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius: 5)
                                    .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                Text("경매 예정")
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
                    
                } else {
                    ZStack(alignment: .topLeading) {
                        
                        Image("smallAppIcon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                            .clipped()
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("\(product.productName)")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 10)
                    
                    Text("\(product.winningPrice ?? 0)원")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
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
        .padding()
        .sheet(isPresented: $isShowReportDetailSheet, content: {
            ReportAuctionDetailSheetView(reportStore: reportStore, product: product)
        })
    }
}
