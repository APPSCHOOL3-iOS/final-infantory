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
        VStack {
            if auctionViewModel.filteredProduct.isEmpty {
                emptyListItemCell
            } else {
                ScrollView {
                    ForEach(auctionViewModel.filteredProduct) { product in
                        HStack {
                            AuctionInfluencerImageView(product: product)
                            
                            Spacer()
                            
                            AuctionTimerView(product: product)
                        }
                        .horizontalPadding()
                        
                        AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
                    }
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

extension ProductListView {
    var emptyListItemCell: some View {
        VStack {
            Spacer()
            if auctionViewModel.selectedFilter == .inProgress {
                Text("진행중인 경매가 없습니다.")
            } else if auctionViewModel.selectedFilter == .planned {
                Text("진행 예정인 경매가 없습니다.")
            } else {
                Text("종료된 경매가 없습니다.")
            }
            Spacer()
        }
        .font(.infanBody)
        .foregroundColor(.infanGray)
    }
}
