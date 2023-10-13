//
//  AuctionBidSheetView.swift
//  Infantory
//
//  Created by 변상필 on 10/4/23.
//

import SwiftUI

// 헤드라인, 바디, 헤드라인 볼드, 풋노트?

struct AuctionBidSheetView: View {
    @ObservedObject var auctionStore: AuctionStore
    
    @EnvironmentObject var loginStore: LoginStore
    
    @Binding var isShowingAuctionBidSheet: Bool
    
    @State private var selectedIndex: Int = 4 // 선택된 버튼
    @State private var selectedAmount: Int = 0 // 선택된 금액
    
    @Binding var showAlert: Bool

    var isSelected: Bool {
        return selectedAmount == 0
    }
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                
                ForEach(1..<4) { index in
                    bidSelectButton(bidAmount: (auctionStore.biddingInfos.last?.biddingPrice ?? auctionStore.product.minPrice) + auctionStore.bidIncrement * index, index: index)
                }
                Button {
                    auctionStore.addBid(biddingInfo: BiddingInfo(id: UUID(),
                                                                     timeStamp: Date(),
                                                                 userID: "\(loginStore.userUid)",
                                                                 userNickname: "\(loginStore.currentUser.name)",
                                                                     biddingPrice: selectedAmount))
                    isShowingAuctionBidSheet.toggle()
                    showAlert = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showAlert = false
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? .infanGray : Color.infanMain)
                        .overlay {
                            if isSelected {
                                Text("입찰하기")
                            } else {
                                Text("\(selectedAmount)원 입찰하기")
                            }
                        }
                        .foregroundColor(.white)
                        .font(.infanHeadlineBold)
                        .frame(width: .screenWidth - 40, height: 54)
                }
                .disabled(isSelected)
                
            }
            
        }
    }
}

extension AuctionBidSheetView {
    var headerView: some View {
        VStack {
            VStack(spacing: 8) {
                Text("입찰가 선택")
                    .font(.infanHeadlineBold)
                
                Text("\(auctionStore.product.productName)")
                
                HStack {
                    Text(" \(auctionStore.biddingInfos.last?.biddingPrice ?? 0)원")
                        .foregroundColor(.infanMain)
                    
                    TimerView(remainingTime: auctionStore.remainingTime)
                }
                
            }
            .padding(.bottom)
        }
    }
}

extension AuctionBidSheetView {
    func bidSelectButton(bidAmount: Int, index: Int) -> some View {
        
        Button {
            selectedAmount = bidAmount
            selectedIndex = index
        } label: {
            
            ZStack {
                Text("\(bidAmount)원")
                    .font(.infanHeadline)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(index == selectedIndex ? Color.infanMain : Color.white)
                    .opacity(0.3)
                    .frame(width: .screenWidth - 40, height: 54)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle())
                    .foregroundColor(.gray)
                    .frame(width: .screenWidth - 40, height: 54)
            }
            .horizontalPadding()
        }
        .buttonStyle(.plain)
        .padding(.bottom, 8)
    }
}

struct AuctionBidSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionBidSheetView(auctionStore: AuctionStore(product: AuctionProduct.dummyProduct), isShowingAuctionBidSheet: .constant(true), showAlert: .constant(true))
    }
}
