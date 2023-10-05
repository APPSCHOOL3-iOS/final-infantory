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
    
    @State private var selectedAmount: Int = 0 // 선택된 금액
    @State private var selectedIndex: Int = 1 // 선택된 버튼
    
    var body: some View {
        VStack {
            Text("입찰가 선택")
                .font(.infanTitle2Bold)
                .padding(.bottom, 5)
            
            Text("멋쟁이 신발")
                .padding(.bottom, 5)
            
            HStack {
                Text("\(auctionViewModel.biddingInfos.last?.biddingPrice ?? 0)")
                Text("•")
                Label("\(InfanDateFormatter.shared.timeString(from: auctionViewModel.biddingInfos.last?.timeStamp ?? Date()))", systemImage: "timer")

            }
            .foregroundColor(.infanMain)
            .font(.infanFootnote)
            .padding(.bottom)
            
            ForEach(1..<4) { index in
                bidSelectButton(bidAmount:  (auctionViewModel.biddingInfos.last?.biddingPrice ?? 0) + auctionViewModel.bidIncrement * index, index: index)
             
            }
            
            Button {
//                auctionViewModel.addBid(forAuction: "1", biddingInfo: BiddingInfo(id: UUID(), timeStamp: Date(), participants: "갓희찬", biddingPrice: 50000))
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.infanMain)
                    .overlay {
                        Text("\(selectedAmount) 입찰하기")
                            .font(.infanHeadlineBold)
                            .foregroundStyle(.white)
                            
                    }
                    .infanHorizontalPadding()
                    .frame(width: .infinity, height: 54)
            }
        }
    }
}

extension AuctionBidSheetView {
    func bidSelectButton(bidAmount: Int, index: Int) -> some View {
        
        Button {
            // 입찰 금액 선택 버튼
            selectedAmount = bidAmount
            selectedIndex = index
        } label: {
            if index == selectedIndex {
                Rectangle()
                    .stroke(lineWidth: 1)
                    .background(Color.infanMain)
                    .cornerRadius(8)
//                    .fill(Color.infanMain)
                    .opacity(0.3)
                    .overlay {
                        Text("\(bidAmount)")
                            .font(.infanHeadline)
                            .foregroundColor(.infanMain)
                            .padding()
                    }
                
                    .infanHorizontalPadding()
                    .frame(width: .infinity, height: 54)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .cornerRadius(8)
                    .overlay {
                        Text("\(bidAmount)")
                            .font(.infanHeadline)
                            .padding()
                    }
                    .infanHorizontalPadding()
                    .frame(width: .infinity, height: 54)
            }
        }
        .buttonStyle(.plain)
        .padding(.bottom, 8)
    }
}

struct AuctionBidSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionBidSheetView(auctionViewModel: AuctionViewModel())
    }
}

//#Preview {
//    AuctionBidSheetView()
//}
