//
//  InfluencerAuctionListView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/18.
//

import SwiftUI

struct InfluencerApplyListView: View {
    
    @EnvironmentObject private var influencerStore: InfluencerStore
    @ObservedObject var applyProductStore: ApplyProductStore

    let columns = [GridItem(.fixed(.screenWidth / 3)), GridItem(.fixed(.screenWidth / 3)), GridItem(.fixed(.screenWidth / 3))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(influencerStore.influencerApplyProduct) { product in
                NavigationLink {
                    ApplyDetailView(applyProductStore: applyProductStore, product: product)
                } label: {
                    if product.productImageURLStrings.count > 0 {
                        CachedImage(url: product.productImageURLStrings[0]) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .scaledToFill()
                                    .clipped()
                            case .success(let image):
                                if product.applyFilter == .close {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 2) / 3, height: (.screenWidth - 2) / 3)
                                            .blur(radius: 5)
                                            .clipped()
                                        
                                        Text("응모 종료")
                                            .padding(10)
                                            .bold()
                                            .foregroundColor(.white)
                                            .background(Color.infanDarkGray)
                                            .cornerRadius(20)
                                    }
                                    
                                } else if product.applyFilter == .planned {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 2) / 3, height: (.screenWidth - 2) / 3)
                                            .blur(radius: 5)
                                            .clipped()
                                        
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
                                        .frame(width: (.screenWidth - 2) / 3, height: (.screenWidth - 2) / 3)
                                        .clipped()
                                }
                            case .failure:
                                Image(systemName: "xmark")
                                
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                    } else {
                        Image("smallAppIcon")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                }
            }
        }
    }
}

struct InfluencerApplyListView_Previews: PreviewProvider {
    static var previews: some View {
        InfluencerApplyListView(applyProductStore: ApplyProductStore())
    }
}
