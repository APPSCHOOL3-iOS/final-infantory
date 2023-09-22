//
//  AuctionButtonCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct AuctionButtonCell: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Text("진행경매")
                    .frame(width: 95, height: 30)
                    .foregroundColor(.infanLightGray)
                    .background(Color.infanDarkGray)
                    .cornerRadius(15)
            })
            Button(action: {}, label: {
                Text("예정경매")
                    .frame(width: 95, height: 30)
                    .foregroundColor(.infanDarkGray)
                    .background(Color.infanLightGray)
                    .cornerRadius(15)
            })
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AuctionButtonCell_Previews: PreviewProvider {
    static var previews: some View {
        AuctionButtonCell()
    }
}
