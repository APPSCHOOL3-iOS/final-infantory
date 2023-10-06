//
//  AuctionDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/25.
//

import SwiftUI

struct AuctionDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    @StateObject var auctionViewModel: AuctionViewModel = AuctionViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                // 인플루언서 프로필

                Divider()
                
                AuctionBuyerView()
                
                AuctionItemImage()
                    .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                    .cornerRadius(8)
                
                HStack {
                    Text("멋쟁이 신발")
                        .font(.infanTitle2)
                    Spacer()
                    // 남은 시간
                    Label("03:22:15", systemImage: "timer")
                        .foregroundColor(.infanMain)
                        .font(.infanFootnote)
                }
                .padding(.top)
                .infanHorizontalPadding()
                
                // 제품 설명
                Text("제품 설명 최대 3줄로 하고 리딩 정렬하고 3줄 넘으면 ...으로 보이게 하rl제품 설명 최대 3줄로 하고 리딩 정렬하고 3줄 넘으면 ...으로 보이게 하rl제품 설명 최대 3줄로 하고 리딩 정렬하고 3줄 넘으면 ...으로 보이게 하rl")
                //                    .lineLimit(3)
                    .infanHorizontalPadding()
                    .padding(.top)
                    .padding(.bottom, 100)
            }
            
            Footer(auctionViewModel: AuctionViewModel())
            
        }        
    }
}

// MARK: - 경매하기 버튼 Footer
struct Footer: View {
    @ObservedObject var auctionViewModel: AuctionViewModel
    
    @State private var isShowingAuctionBidSheet: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isShowingAuctionBidSheet.toggle()
                print("footer \(auctionViewModel.biddingInfos)")
            } label: {
                Text("입찰 \(auctionViewModel.biddingInfos.last?.biddingPrice ?? 123)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.infanMain)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            }
            .offset(y: -20)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 110)
        .background(
            Rectangle()
                .stroke(lineWidth: 0.1)
                .background(.white)
            
        )
        .offset(x: 0, y: 40)
        .sheet(isPresented: $isShowingAuctionBidSheet, content: {
            AuctionBidSheetView()
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        })
    }
}

struct AuctionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionDetailView(auctionProductViewModel: AuctionProductViewModel())
                .environmentObject(LoginStore())
        }
    }
}
