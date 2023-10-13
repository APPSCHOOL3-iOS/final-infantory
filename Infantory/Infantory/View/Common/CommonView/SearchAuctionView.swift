//
//  SearchAuctionView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/12/23.
//

import SwiftUI

struct SearchAuctionView: View {
    
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    
    var body: some View {
        ForEach(auctionViewModel.auctionProduct) { product in
            AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
        }
    }
}

struct SearchAuctionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAuctionView(auctionViewModel: AuctionProductViewModel())
    }
}
