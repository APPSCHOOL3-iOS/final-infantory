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
    
    @ObservedObject var auctionStore: AuctionStore
    
    @State private var isShowingActionSheet: Bool = false
    @State private var isShowingReportSheet: Bool = false
    
    @State private var toastMessage: String = ""
    @State private var isShowingToastMessage: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                Divider()
                
                AuctionBuyerView(auctionStore: auctionStore)
                
                HStack {
                    AuctionInfluencerImageView(product: auctionStore.product)
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingActionSheet = true
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
                    .buttonStyle(.plain)
                }
                .horizontalPadding()
                .padding(.bottom, 5)
                
                AuctionItemImage(imageString: auctionStore.product.productImageURLStrings)
                    .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                    .cornerRadius(10)
                ToastMessage(content: Text("\(toastMessage)"), isPresented: $isShowingToastMessage)
                productInfo
            }
            Footer(auctionStore: auctionStore)
        }
        .onAppear {
            finishAuction(product: &auctionStore.product)
        }
        .navigationBar(title: "상세정보")
        .confirmationDialog("", isPresented: $isShowingActionSheet) {
            
            Button("신고하기", role: .destructive) {
                isShowingActionSheet = false
                isShowingReportSheet = true
            }
            
            Button("저장하기", role: .none) {
                
            }
            Button("취소", role: .cancel) {}
            
        }
        .sheet(isPresented: $isShowingReportSheet) {
            AuctionReportSheetView(product: auctionStore.product, toastMessage: $toastMessage, isShowingToastMessage: $isShowingToastMessage)
        }
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
    @State var isShowingPaymentSheet: Bool = false
    @State private var showAlert: Bool = false
    @State private var isShowingLoginSheet: Bool = false
    @State private var isHighestBidder: Bool = false
    @State private var highestBidderState: Bool = false
    
    var body: some View {
        
        VStack {
            ToastMessage(content: Text("입찰 성공!!!"), isPresented: $showAlert)
            Button {
                if loginStore.currentUser.id?.isEmpty ?? true {
                    isShowingLoginSheet = true
                } else {
                    if loginStore.warning == false {
                        isShowingAuctionBidSheet = true
                    } else {
                        isShowingAuctionNoticeSheet = true
                    }
                }
                
//                if loginStore.userUid.isEmpty {
//                    isShowingLoginSheet = true
//                }
//                if loginStore.warning == false {
//                    isShowingAuctionBidSheet = true
//                } else {
//                    isShowingAuctionNoticeSheet = true
//                }
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
                    if auctionStore.product.isPaid == true {
                        Text("결제 완료")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.infanGray)
                                    .frame(width: CGFloat.screenWidth - 40, height: 54)
                            )
                    } else if auctionStore.biddingInfos.last?.userID == loginStore.currentUser.id {
                        Button {
                            isShowingPaymentSheet = true
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.infanMain)
                                .frame(width: CGFloat.screenWidth - 40, height: 54)
                                .overlay {
                                    Text("결제하기")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
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
                      isHighestBidder && auctionStore.biddingInfos.last?.userID != loginStore.currentUser.id || (isHighestBidder && auctionStore.product.auctionFilter == .inProgress || auctionStore.product.isPaid == true)
            )
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
            AuctionBidSheetView(auctionStore: auctionStore, isShowingAuctionBidSheet: $isShowingAuctionBidSheet, showAlert: $showAlert, highestBidderState: $highestBidderState)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isShowingLoginSheet) {
            LoginSheetView()
                .environmentObject(loginStore)
        }
        .sheet(isPresented: $isShowingPaymentSheet) {
            PaymentView(paymentStore: PaymentStore(user: loginStore.currentUser, product: auctionStore.product),
                        paymentInfo: PaymentInfo(userId: loginStore.currentUser.id ?? "",
                                                 auctionProduct: auctionStore.product,
                                                 applyProduct: nil,
                                                 address: loginStore.currentUser.address,
                                                 deliveryRequest: .door,
                                                 deliveryCost: 3000,
                                                 paymentMethod: PaymentMethod.accountTransfer),
                        isShowingPaymentSheet: $isShowingPaymentSheet
            )
        }
        .onAppear {
            if auctionStore.biddingInfos.last?.userID == loginStore.currentUser.id {
                isHighestBidder = true
            }
        }
        .onChange(of: highestBidderState) { value in
            isHighestBidder = value
        }
    }
}

extension AuctionDetailView {
    var productInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                
                // 남은 시간
                TimerView(remainingTime: auctionStore.remainingTime)
                Spacer()
            }
            .horizontalPadding()
            .padding([.top, .bottom], 5)
            
            VStack(alignment: .leading) {
                Text("\(auctionStore.product.productName)")
                    .font(.infanTitle2Bold)
                    .padding(.bottom)
                
                // 제품 설명
                Text("\(auctionStore.product.description)")
                    .font(.infanBody)
                    .foregroundColor(.primary)
                    .padding(.bottom, 100)
                    .multilineTextAlignment(.leading)
            }
            .horizontalPadding()
        }
    }
}
