//
//  AuctionProductViewModel.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/22.
//

import Foundation

final class AuctionProductViewModel: ObservableObject {
    @Published var auctionProduct: [AuctionProduct] = [AuctionProduct.sampleData]
}
