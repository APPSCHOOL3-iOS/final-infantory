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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                Divider()
                
                AuctionBuyerView(auctionStore: auctionStore)
                
                ProfileRowView(imageURLString: auctionStore.product.influencerProfile ?? "", nickname: auctionStore.product.influencerNickname)
                
                AuctionItemImage(imageString: auctionStore.product.productImageURLStrings)
                    .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                    .cornerRadius(10)
                
                productInfo
            }
            Footer(auctionStore: auctionStore)
        }
        .onAppear {
            finishAuction(product: &auctionStore.product)
        }
        .navigationBar(title: "상세정보")
    }
    
    // 경매가 끝났고, 내가 최고 입찰자라면 product.winningUserID에 추가하는 로직 만들기
    func finishAuction(product: inout AuctionProduct) {
        if auctionStore.product.auctionFilter == .close {
            product.winningUserID = auctionStore.biddingInfos.last?.userID
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
    @State private var isHighestBidder: Bool = false
    
    var body: some View {
        
        VStack {
            ToastMessage(content: Text("입찰 성공!!!"), isPresented: $showAlert)
            Button {
                if loginStore.userUid.isEmpty {
                    isShowingLoginSheet = true
                }
                if loginStore.warning == false {
                    isShowingAuctionBidSheet = true
                } else {
                    isShowingAuctionNoticeSheet = true
                }
            } label: {
                if auctionStore.product.auctionFilter == .inProgress {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isHighestBidder ? Color.infanGray : Color.infanMain)
                        .frame(width: CGFloat.screenWidth - 40, height: 54)
                        .overlay {
                            Text( isHighestBidder ? "현재 최고입찰자입니다" : "입찰 \(auctionStore.biddingInfos.last?.biddingPrice ?? auctionStore.product.minPrice) 원")
                                .font(.infanHeadlineBold)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                } else if auctionStore.product.auctionFilter == .planned {
                    Text("경매 시작 전입니다.")
                        .font(.infanHeadlineBold)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.infanGray)
                                .frame(width: CGFloat.screenWidth - 40, height: 54)
                        )
                } else {
                    if auctionStore.biddingInfos.last?.userID == loginStore.currentUser.id {
                        NavigationLink {
                            PaymentView()
                        } label: {
                            Text("결제하기")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.infanMain)
                                        .frame(width: CGFloat.screenWidth - 40, height: 54)
                                )
                                .contentShape(Rectangle())
                            
                        }
                    } else {
                        Text("이미 종료된 경매입니다.")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.infanGray)
                                    .frame(width: CGFloat.screenWidth - 40, height: 54)
                            )
                    }
                }
            }
            .disabled((auctionStore.product.auctionFilter == .close && (auctionStore.biddingInfos.last?.userID != loginStore.currentUser.id)) ||
                          auctionStore.product.auctionFilter == .planned ||
                          isHighestBidder && auctionStore.biddingInfos.last?.userID != loginStore.currentUser.id)
            .offset(y: -20)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 110)
        .offset(x: 0, y: 40)
        .sheet(isPresented: loginStore.warning ? $isShowingAuctionNoticeSheet : loginStore.$warning, onDismiss: {
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
        .onAppear {
            if auctionStore.biddingInfos.last?.userID == loginStore.currentUser.id {
                isHighestBidder = true
            }
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
