//
//  ApplyBuyerView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/04.
//

import SwiftUI

struct ApplyBuyerView: View {
    
    var product: ApplyProduct
    
    var body: some View {
        HStack {
            if product.applyFilter != .planned {
                Text("전체응모횟수")
                Spacer()
                Text("\(product.applyUserIDs.count) 회")
            } else {
                Spacer()
                Text("\(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .fill(Color.infanMain))
        .horizontalPadding()
        .frame(width: .screenWidth, height: 80)
    }
}

struct ApplyBuyerView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyBuyerView(product: ApplyProduct(
            id: "1",
            productName: "Product 1",
            productImageURLStrings: ["image1", "image2", "image3"],
            description: "This is the description for Product 1",
            influencerID: "influencer1",
            influencerNickname: "",
            winningUserID: "user1",
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400), // 1 day from now
            applyUserIDs: ["user2", "user3"],
            winningPrice: 100
        ))
    }
}
