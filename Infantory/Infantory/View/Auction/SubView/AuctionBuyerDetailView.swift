//
//  AuctionBuyerDetailView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/28.
//

import SwiftUI

struct AuctionBuyerDetailView: View {
    @Binding var receivedBiddingData: [BiddingInfo]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(receivedBiddingData.reversed(), id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                                Text("\(index.userNickname)")
                                    .font(.infanHeadlineBold)
                            
                            Spacer()
                            Text("\(InfanDateFormatter.shared.dateTimeString(from: index.timeStamp))")
                                .font(.infanFootnoteBold)
                                .foregroundColor(.infanGray)
                            
                        }
                        Spacer()
                        Text("\(index.biddingPrice)원")
                            .font(.infanHeadlineBold)
                            .foregroundColor(.infanMain)
                    }
                    Divider()
                        .padding(.vertical)
                }
            }
            .padding()
            .navigationBar(title: "입찰현황")
        }
    }
}

