//
//  AuctionBidSheetView.swift
//  Infantory
//
//  Created by 변상필 on 10/4/23.
//

import SwiftUI

// 헤드라인, 바디, 헤드라인 볼드, 풋노트?

struct AuctionBidSheetView: View {
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
                Text("11000 원")
                Text("•")
                Text("03:22:15")
            }
            .foregroundColor(.gray)
            .padding(.bottom)
            
            ForEach(1..<4) { index in
                    bidSelectButton(bidAmount: 10000 * index, index: index)
             
            }
            
            Button {

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

#Preview {
    AuctionBidSheetView()
}
