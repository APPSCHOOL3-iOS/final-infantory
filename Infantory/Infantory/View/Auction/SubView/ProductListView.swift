//
//  ProductCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct ProductListView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(auctionViewModel.auctionProduct) { product in
                    AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
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
