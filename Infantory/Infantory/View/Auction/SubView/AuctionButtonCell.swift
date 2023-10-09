//
//  AuctionButtonCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct AuctionButtonCell: View {
    
    @State private var selectedFilter = AuctionFilter.inProgress
    
    var body: some View {
        HStack {
            ForEach(AuctionFilter.allCases, id: \.rawValue) { filter in
                Button {
                    selectedFilter = filter
                } label: {
                    if selectedFilter == filter {
                        Text(filter.rawValue)
                            .padding(10)
                            .font(.infanFootnoteBold)
                            .foregroundColor(.white)
                            .background(Color.infanDarkGray)
                            .cornerRadius(20)
                    } else {
                        Text(filter.rawValue)
                            .padding(10)
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray)
                            .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.infanLightGray, lineWidth: 1)
                            )
                    }
                }
            }
            Spacer()
        }
        .horizontalPadding()
    }
}

struct AuctionButtonCell_Previews: PreviewProvider {
    static var previews: some View {
        AuctionButtonCell()
    }
}
