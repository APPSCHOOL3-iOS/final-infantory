//
//  AuctionTimerVIew.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/18.
//

import SwiftUI

struct AuctionTimerView: View {
    
    var product: AuctionProduct
    
    var body: some View {
        if product.auctionFilter == .planned {
            Text("\(Image(systemName: "timer")) \(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                .font(.infanFootnote)
                .foregroundColor(.infanOrange)
        } else if product.auctionFilter == .close {
            
        } else {
            TimerView(remainingTime: product.endDate.timeIntervalSince(Date()))
        }
    }
}

struct AuctionTimerVIew_Previews: PreviewProvider {
    static var previews: some View {
        AuctionTimerView(product: AuctionProduct(id: "", productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "", influencerProfile: "", winningUserID: "", startDate: Date(), endDate: Date(), registerDate: Date(), minPrice: 0, winningPrice: 0))
    }
}
