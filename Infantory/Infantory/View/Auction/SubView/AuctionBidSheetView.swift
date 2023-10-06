//
//  AuctionBidSheetView.swift
//  Infantory
//
//  Created by 변상필 on 10/4/23.
//

import SwiftUI

// 헤드라인, 바디, 헤드라인 볼드, 풋노트?

struct AuctionBidSheetView: View {
    @ObservedObject var auctionViewModel: AuctionViewModel
    
    @Binding var isShowingAuctionBidSheet: Bool
    
    @State private var selectedIndex: Int = 4 // 선택된 버튼
    @State private var selectedAmount: Int = 0 // 선택된 금액
    
    @State private var showAlert: Bool = false
    
    var isSelected: Bool {
        return selectedAmount == 0
    }
    
    var body: some View {
        VStack {
            headerView
            
            ForEach(1..<4) { index in
                bidSelectButton(bidAmount: (auctionViewModel.biddingInfos.last?.biddingPrice ?? 0) + auctionViewModel.bidIncrement * index, index: index)
                
            }
            
            Button {
                auctionViewModel.addBid(biddingInfo: BiddingInfo(id: UUID(),
                                                                 timeStamp: Date(),
                                                                 participants: "갓희찬",
                                                                 biddingPrice: selectedAmount))
                isShowingAuctionBidSheet.toggle()
                showAlert = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showAlert = false
                }
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? .gray.opacity(0.3) : Color.infanMain)
                    .overlay {
                        Text("\(isSelected ? "" : "\(selectedAmount)") 입찰하기")
                            .font(.infanHeadlineBold)
                            .foregroundStyle(.white)
                        
                    }
                    .infanHorizontalPadding()
                    .frame(width: .infinity, height: 54)
            }
            .disabled(isSelected)
        }
        .alert(isPresented: $showAlert) {
            // 상필님이 커스텀 얼럿 만들어 주신답니다!!
            Alert(title: Text(""), message: Text("입찰 성공!!!!"))
        }
    }
}

extension AuctionBidSheetView {
    var headerView: some View {
        VStack {
            VStack {
                Text("현재 입찰가: \(auctionViewModel.biddingInfos.last?.biddingPrice ?? 0)")
                    .padding()
                TimerView(remainingTime: auctionViewModel.remainingTime)
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
                Text("\(bidAmount)")
                    .font(.infanHeadline)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(index == selectedIndex ? Color.infanMain : Color.white)
                    .opacity(0.3)
                    .frame(width: .infinity, height: 54)
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle())
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 54)
            }
            .infanHorizontalPadding()
        }
        .buttonStyle(.plain)
        .padding(.bottom, 8)
    }
}

struct AuctionBidSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionBidSheetView(auctionViewModel: AuctionViewModel(), isShowingAuctionBidSheet: .constant(true))
    }
}
