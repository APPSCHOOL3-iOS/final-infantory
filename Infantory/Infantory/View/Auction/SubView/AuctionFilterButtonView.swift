//
//  AuctionButtonCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct AuctionFilterButtonView: View {
    @ObservedObject var auctionViewmodel: AuctionProductViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(AuctionFilter.allCases, id: \.rawValue) { filter in
                    Button {
                        auctionViewmodel.updateFilter(filter: filter)
                    } label: {
                        if auctionViewmodel.selectedFilter == filter {
                            Text(filter.rawValue)
                                .padding(10)
                                .font(.infanFootnoteBold)
                                .foregroundColor(.white)
                                .background(Color.infanDarkGray)
                                .cornerRadius(10)
                        } else {
                            Text(filter.rawValue)
                                .padding(10)
                                .font(.infanFootnote)
                                .foregroundColor(.infanDarkGray)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.infanLightGray, lineWidth: 1)
                                )
                        }
                    }
                }
                Spacer()
            }
            
            if auctionViewmodel.selectedFilter == .inProgress {
                HStack {
                    ForEach(AuctionInprogressFilter.allCases, id: \.rawValue) { filter in
                        Button {
                            auctionViewmodel.progressSelectedFilter = filter
                            auctionViewmodel.sortInProgressProduct(filter: filter)
                        } label: {
                            if auctionViewmodel.progressSelectedFilter == filter {
                                Text(filter.rawValue)
                                    .padding(10)
                                    .font(.infanFootnoteBold)
                                    .foregroundColor(.infanMain)
                                
                            } else {
                                Text(filter.rawValue)
                                    .padding(10)
                                    .font(.infanFootnote)
                                    .foregroundColor(.infanDarkGray)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .horizontalPadding()
    }
}

struct AuctionFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionFilterButtonView(auctionViewmodel: AuctionProductViewModel())
    }
}
