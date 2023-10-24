//
//  HomeHotAuctionView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/15.
//

import SwiftUI

// 1. 진행중인 상품목록을 가져온다
// 2. 진행중인 상품목록 중 참여를 많이한 순으로 Sort한다.
struct HomeHotAuctionView: View {
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    private var sortFilteredProduct: [AuctionProduct] {
        return auctionViewModel.filteredProduct.sorted {
            $0.count ?? 0 > $1.count ?? 0
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(sortFilteredProduct) { product in
                    NavigationLink {
                        AuctionDetailView(auctionStore: AuctionStore(product: product))
                    } label: {
                        VStack(alignment: .leading) {
                            AuctionCountView(productID: product.id ?? "")
                            
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
                                Image("smallAppIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (.screenWidth - 100) / 2,
                                           height: (.screenWidth - 100) / 2)
                                    .clipped()
                            }
                            
                            VStack(alignment: .leading) {
                                Text(product.influencerNickname)
                                    .bold()
                                    .foregroundColor(.infanBlack)
                                
                                Text(product.productName)
                                    .foregroundColor(.infanBlack)
                                    .lineLimit(1)
                                
                                WinningPriceView(productID: product.id ?? "")
                            }
                            .font(.infanFootnote)
                        }
                        .padding()
                    }
                    .frame(width: (.screenWidth - 100) / 2)
                }
                .padding(.leading, 20)
            }
        }
        .frame(height: ((.screenWidth - 100) / 2) + 80)
        .scrollIndicators(.hidden)
    }
}

struct HomeHotAuctionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHotAuctionView(auctionViewModel: AuctionProductViewModel())
    }
}

struct WinningPriceView: View {
    let productID: String
    @StateObject var myActivityStore = MyActivityStore()
    
    var body: some View {
        HStack {
            Image(systemName: "arrowtriangle.up.fill")
                .foregroundColor(.infanRed)
            
            TextAnimateView(value: myActivityStore.winningPrice)
                .foregroundColor(Color.infanRed)
                .monospacedDigit()
                .animation(Animation.easeInOut(duration: 1))
        }
        .font(.infanFootnote)
        .onAppear {
            myActivityStore.fetchWinningPrice(productID: productID)
        }
    }
}

struct AuctionCountView: View {
    let productID: String
    @StateObject var myActivityStore = MyActivityStore()
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .padding(3)
                .foregroundColor(.clear)
                .frame(width: (.screenWidth - 200) / 2, height: .screenHeight * 0.025)
                .background(Color.clear)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 0.5)
                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom), lineWidth: 1.5)
                    
                )
            
            Label("\(myActivityStore.auctionCount)회 참여", systemImage: "person.2.fill")
                .font(.infanFootnote)
                .foregroundColor(.infanBlack)
        }
        .onAppear {
            myActivityStore.fetchAuctionCount(productID: productID)
        }
    }
}
