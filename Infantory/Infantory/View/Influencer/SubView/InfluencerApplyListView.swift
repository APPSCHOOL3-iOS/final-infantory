//
//  InfluencerAuctionListView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/18.
//

import SwiftUI

struct InfluencerApplyListView: View {
    
    @EnvironmentObject private var influencerStore: InfluencerStore
    @ObservedObject var applyViewModel: ApplyProductStore
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
//            ForEach(influencerStore.influencerApplyProduct) { product in
//                NavigationLink {
//                    ApplyDetailView(applyViewModel: applyViewModel, product: product)
//                } label: {
//                    if product.productImageURLStrings.count > 0 {
//                        CachedImage(url: product.productImageURLStrings[0]) { phase in
//                            switch phase {
//                            case .empty:
//                                ProgressView()
//                                    .scaledToFill()
//                                    .frame(width: (.screenWidth - 100) / 2,
//                                           height: (.screenWidth - 100) / 2)
//                                    .clipped()
//                            case .success(let image):
//                                if product.auctionFilter == .close {
//                                    ZStack {
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//                                            .blur(radius: 5)
//                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
//                                            .clipped()
//                                            .cornerRadius(10)
//
//                                        Text("경매 종료")
//                                            .padding(10)
//                                            .bold()
//                                            .foregroundColor(.white)
//                                            .background(Color.infanDarkGray)
//                                            .cornerRadius(20)
//                                    }
//
//                                } else if product.auctionFilter == .planned {
//                                    ZStack {
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//                                            .blur(radius: 5)
////                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
//                                            .clipped()
//                                            .cornerRadius(10)
//
//                                        Text("응모 예정")
//                                            .padding(10)
//                                            .bold()
//                                            .foregroundColor(.white)
//                                            .background(Color.infanOrange)
//                                            .cornerRadius(20)
//                                    }
//                                } else {
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
////                                        .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
//                                        .clipped()
//                                        .cornerRadius(10)
//                                }
//                            case .failure:
//                                Image(systemName: "xmark")
////                                    .frame(width: (.screenWidth - 100) / 2,
////                                           height: (.screenWidth - 100) / 2)
//
//                            @unknown default:
//                                EmptyView()
//                            }
//                        }
//
//                    } else {
//                        ZStack(alignment: .topLeading) {
//
//                            Image("smallAppIcon")
//                                .resizable()
//                                .scaledToFill()
////                                .frame(width: (.screenWidth - 100) / 2,
////                                       height: (.screenWidth - 100) / 2)
//                                .clipped()
//
//                        }
//                    }
//                }
//            }
        }
    }
}

struct InfluencerApplyListView_Previews: PreviewProvider {
    static var previews: some View {
        InfluencerApplyListView(applyViewModel: ApplyProductStore())
    }
}
