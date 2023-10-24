//
//  ApplyListCellView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

struct ApplyListCellView: View {
    
    @ObservedObject var applyViewModel: ApplyLotteryStore
    var product: ApplyProduct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("\(product.influencerNickname)")
                .font(.title2.bold())
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
                        
                        if product.raffleDate != nil {
                            Text("당첨자: \(product.winningUserID ?? "")")
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.leading)
                            
                            Text("추첨일: \(product.dateToString)")
                                .font(.footnote)
                                .foregroundColor(.orange)
                                .multilineTextAlignment(.leading)
                        }
                        
                    }
                    Spacer()
                }

            }
        }
        .padding()
    }
}

struct ApplyListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyListCellView(applyViewModel: ApplyLotteryStore(), product: ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), registerDate: Date(), applyUserIDs: [""]))
    }
}
