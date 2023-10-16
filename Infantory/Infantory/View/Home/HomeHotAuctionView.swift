//
//  HomeHotAuctionView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/15.
//

import SwiftUI

// 여기 auctionStore가져와서 많이 경매참여한 순으로 바꿔야함 ㅜ 
struct HomeHotAuctionView: View {
    
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(auctionViewModel.filteredProduct) { product in
                    NavigationLink {
                        AuctionDetailView(auctionProductViewModel: auctionViewModel, auctionStore: AuctionStore(product: product))
                    } label: {
                        VStack(alignment: .leading) {
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
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
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
                                .padding(8)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(product.influencerNickname)
                                    .font(.infanFootnote)
                                Text("\(product.minPrice) 원") // 이거 현재 최고가로 바꿔야함
                                    .font(.infanFootnote)
                                    .foregroundColor(Color.infanDarkGray)
                            }
                            .padding()
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct HomeHotAuctionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHotAuctionView(auctionViewModel: AuctionProductViewModel())
    }
}
