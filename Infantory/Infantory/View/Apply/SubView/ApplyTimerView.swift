//
//  ApplyTimerView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/18.
//

import SwiftUI

struct ApplyTimerView: View {
    
    @ObservedObject var applyProductStore: ApplyProductStore
    var product: ApplyProduct
    
    var body: some View {
        if product.applyFilter == .planned {
            Text("\(Image(systemName: "timer")) \(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                .font(.infanFootnote)
                .foregroundColor(.infanOrange)
        } else if product.applyFilter == .close {
            
        } else {
            TimerView(remainingTime: applyProductStore.remainingTime(product: product))
        }
    }
}

struct ApplyTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyTimerView(applyProductStore: ApplyProductStore(), product: ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), registerDate: Date(), applyUserIDs: [""]))
    }
}
