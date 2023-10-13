//
//  ProductCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(auctionViewModel.filteredProduct) { product in

                    AuctionInfluencerImageView(auctionViewModel: auctionViewModel, product: product)
                    AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
                }
            }
        }
        .refreshable {
            Task {
                do {
                    try await auctionViewModel.fetchAuctionProducts()
                } catch {
                    
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await auctionViewModel.fetchAuctionProducts()
                } catch {
                    
                }
            }
        }
    }
}
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductListView(auctionViewModel: AuctionProductViewModel())
                .environmentObject(LoginStore())
        }
    }
}
