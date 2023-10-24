//
//  ApplyProductListCellView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/12.
//

import SwiftUI

struct ApplyProductListCellView: View {
    
    @ObservedObject var applyProductStore: ApplyProductStore
    var product: ApplyProduct
    
    var body: some View {
        NavigationLink {
            ApplyDetailView(applyProductStore: applyProductStore, product: product)
        } label: {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
                    if product.productImageURLStrings.count > 0 {
                        CachedImage(url: product.productImageURLStrings[0]) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .scaledToFill()
                                    .frame(width: (.screenWidth - 100) / 2,
                                           height: (.screenWidth - 100) / 2)
                                    .clipped()
                            case .success(let image):
                                if product.applyFilter == .close {
                                    
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .blur(radius: 5)
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
                                            .cornerRadius(10)
                                        
                                        if product.applyCloseFilter == .beforeRaffle {
                                            Text("추첨중")
                                                .padding(10)
                                                .bold()
                                                .foregroundColor(.white)
                                                .background(Color.infanDarkGray)
                                                .cornerRadius(20)
                                        } else {
                                            Text("추첨종료")
                                                .padding(10)
                                                .bold()
                                                .foregroundColor(.white)
                                                .background(Color.infanDarkGray)
                                                .cornerRadius(20)
                                        }
                                    }
                                } else if product.applyFilter == .planned {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .blur(radius: 5)
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
                                            .cornerRadius(10)
                                        
                                        Text("응모 예정")
                                            .padding(10)
                                            .bold()
                                            .foregroundColor(.white)
                                            .background(Color.infanOrange)
                                            .cornerRadius(20)
                                    }
                                } else {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            case .failure:
                                Image(systemName: "xmark")
                                    .frame(width: (.screenWidth - 100) / 2,
                                           height: (.screenWidth - 100) / 2)
                                
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                    } else {
                        ZStack(alignment: .topLeading) {
                            Image("smallAppIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: (.screenWidth - 100) / 2,
                                       height: (.screenWidth - 100) / 2)
                                .clipped()
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("\(product.productName)")
                            .font(.infanBody)
                            .foregroundColor(.infanDarkGray)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 10)
                        
                        if product.applyFilter != .planned {
                            Text("전체 응모: \(product.applyUserIDs.count) 회")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanDarkGray)
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("시작일  \(InfanDateFormatter.shared.dateTimeString(from: product.startDate))")
                                .font(.infanFootnote)
                                .foregroundColor(.infanGray)
                            
                            Text("마감일  \(InfanDateFormatter.shared.dateTimeString(from: product.endDate))")
                                .font(.infanFootnote)
                                .foregroundColor(.gray)
                                .bold()
                        }
                    }
                }
                Divider()
            }
            .horizontalPadding()
        }
    }
}

struct ApplyProductListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyProductListCellView(applyProductStore: ApplyProductStore(), product: ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), registerDate: Date(), applyUserIDs: [""]))
    }
}
