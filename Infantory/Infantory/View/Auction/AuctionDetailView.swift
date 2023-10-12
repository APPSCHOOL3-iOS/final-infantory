//
//  AuctionDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/25.
//

import SwiftUI
import ExpandableText

struct AuctionDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    
    @ObservedObject var auctionStore: AuctionStore
    
    @State var timer: String = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                Divider()
                
                AuctionBuyerView(auctionStore: auctionStore)
                
                ProfileRowView(nickname: auctionStore.product.influencerNickname)
                
                AuctionItemImage(imageString: auctionStore.product.productImageURLStrings)
                    .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                    .cornerRadius(10)
                
                productInfo            
            }
            Footer(auctionStore: auctionStore)
        }
    }
}

struct AuctionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionDetailView(auctionProductViewModel: AuctionProductViewModel(), auctionStore: AuctionStore(product: AuctionProduct.dummyProduct))
        }
    }
}

struct Footer: View {
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var auctionStore: AuctionStore
    
    @State private var isShowingAuctionNoticeSheet: Bool = false
    
    @State private var isShowingAuctionBidSheet: Bool = false
    
    @State private var showAlert: Bool = false
    
    @State private var isShowingLoginSheet: Bool = false
    
    var body: some View {
        VStack {
            ToastMessage(content: Text("입찰 성공!!!"), isPresented: $showAlert)
                .offset(y: -350)
            Button {
                if !loginStore.userUid.isEmpty {
                    isShowingAuctionNoticeSheet.toggle()
                } else {
                    isShowingLoginSheet = true
                }
            } label: {
                Text(auctionStore.remainingTime <= 0 ? "이미 종료된 경매입니다." : "입찰 \(auctionStore.biddingInfos.last?.biddingPrice ?? auctionStore.product.minPrice) 원")
                    .font(.infanHeadlineBold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(auctionStore.remainingTime <= 0 ? Color.infanGray : Color.infanMain)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            }
            .disabled(auctionStore.remainingTime <= 0)
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
        .sheet(isPresented: $isShowingAuctionNoticeSheet, onDismiss: {
            isShowingAuctionBidSheet.toggle()
        }, content: {
            AuctionNoticeSheetView(auctionViewModel: auctionStore,
                                   isShowingAuctionNoticeSheet: $isShowingAuctionNoticeSheet)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(300)])
            
        })
        .sheet(isPresented: $isShowingAuctionBidSheet) {
            AuctionBidSheetView(auctionStore: auctionStore, isShowingAuctionBidSheet: $isShowingAuctionBidSheet, showAlert: $showAlert)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isShowingLoginSheet) {
            LoginSheetView()
                .environmentObject(loginStore)
        }
        
    }
}

extension AuctionDetailView {
    var productInfo: some View {
        VStack {
            HStack {
                Text("\(auctionStore.product.productName)")
                    .font(.infanTitle2)
                Spacer()
                // 남은 시간
                TimerView(remainingTime: auctionStore.remainingTime)
            }
            .padding(.top)
            .horizontalPadding()
            
            // 제품 설명
            HStack {
            Text("\(auctionStore.product.description)")
                .font(.body)//optional
                .foregroundColor(.primary)//optional
                .padding(.horizontal, 24)//optional
                .padding(.bottom, 100)
                
                Spacer()
            }
        }
    }
}
