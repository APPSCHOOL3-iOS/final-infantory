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
        List {
            ForEach(receivedBiddingData.reversed(), id: \.self) { index in
                Text("\(index.userNickname) - \(index.biddingPrice)")
            }
        }
    }
}

//struct AuctionBuyerDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuctionBuyerDetailView()
//    }
//}
