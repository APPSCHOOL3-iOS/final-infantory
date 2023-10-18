//
//  InfluencerAuctionListView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/18.
//

import SwiftUI

struct InfluencerAuctionListView: View {
    
    @EnvironmentObject private var influencerStore: InfluencerStore
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    let columns = [GridItem(.fixed(.screenWidth / 3)), GridItem(.fixed(.screenWidth / 3)), GridItem(.fixed(.screenWidth / 3))]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(influencerStore.influencerAuctionProduct) { product in
                NavigationLink {
                    AuctionDetailView(auctionStore: AuctionStore(product: product))
                } label: {
                    if product.productImageURLStrings.count > 0 {
                        CachedImage(url: product.productImageURLStrings[0]) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .scaledToFill()
                                    .clipped()
                            case .success(let image):
                                if product.auctionFilter == .close {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: .screenWidth / 3)
                                            .blur(radius: 5)
                                            .clipped()
                                        
                                        Text("경매 종료")
                                            .padding(10)
                                            .bold()
                                            .foregroundColor(.white)
                                            .background(Color.infanDarkGray)
                                            .cornerRadius(20)
                                    }
                                    
                                } else if product.auctionFilter == .planned {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: .screenWidth / 3)
                                            .blur(radius: 5)
                                            .clipped()
                                        
                                        Text("경매 예정")
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
                                        .frame(height: .screenWidth / 3)
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

struct InfluencerAuctionListView_Previews: PreviewProvider {
    static var previews: some View {
        InfluencerAuctionListView(auctionViewModel: AuctionProductViewModel())
    }
}
