//
//  AuctionDetailImageView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/25.
//

import SwiftUI

struct AuctionDetailImageView: View {
    @ObservedObject var auctionProductVIewModel: AuctionProductViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                    ForEach(auctionProductVIewModel.auctionProduct) { product in
                        Image(product.productImageURLStrings[1])
                        Image(product.productImageURLStrings[0])
                    }
            }
        }
    }
}

struct AuctionDetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionDetailImageView(auctionProductVIewModel: AuctionProductViewModel())
    }
}
