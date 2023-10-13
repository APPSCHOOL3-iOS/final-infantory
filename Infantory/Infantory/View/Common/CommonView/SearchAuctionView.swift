//
//  SearchAuctionView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/12/23.
//

import SwiftUI

struct SearchAuctionView: View {
    
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @ObservedObject var searchStore: SearchStore
    var showCellCount: SearchResultCount
    
    var body: some View {
        ScrollView {
            if showCellCount == .underLimit {
                ForEach(auctionViewModel.auctionProduct) { product in
                    AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
                }
            } else {
                ForEach(auctionViewModel.auctionProduct.prefix(3)) { product in
                    AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
                }
            }
        }
        .padding(.bottom, 1)
    }
}

struct SearchAuctionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAuctionView(auctionViewModel: AuctionProductViewModel(), searchStore: SearchStore(), showCellCount: .overLimit)
    }
}
