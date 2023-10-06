//
//  ApplyDetailImageView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailImageView: View {
    @ObservedObject var auctionProductVIewModel: AuctionProductViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                    ForEach(auctionProductVIewModel.auctionProduct) { _ in
//                        Image(product.productImageURLStrings[1])
//                        Image(product.productImageURLStrings[0])
                    }
            }
        }
    }
}

struct ApplyDetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailImageView(auctionProductVIewModel: AuctionProductViewModel())
    }
}
