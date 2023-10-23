//
//  HomeView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import SwiftUI

struct HomeMainView: View {
    
    @StateObject var applyViewModel: ApplyProductStore = ApplyProductStore()
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    @StateObject var searchStore: SearchStore = SearchStore()
    
    @State private var isShowingDetail = false
    var searchCategory: SearchResultCategory = .total
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HomeBannerView(applyViewModel: applyViewModel)
                
                VStack(alignment: .leading) {
                    Text("다양한 인플루언서를 만나보세요!✨")
                        .font(.infanTitle2)
                        .foregroundColor(.infanBlack)
                        .horizontalPadding()
                    HomeInfluencerImageView(applyViewModel: applyViewModel, searchStore: searchStore)
                }
                .padding([.top, .bottom])
                
                VStack(alignment: .leading) {
                    Text("🔥HOT🔥 애장품 경매에 참여해보세요!")
                        .font(.infanTitle2)
                        .foregroundColor(.infanBlack)
                        .horizontalPadding()
                    HomeHotAuctionView(auctionViewModel: auctionViewModel)
                    
                }
                .padding([.top, .bottom])
                
                VStack(alignment: .leading) {
                    Text("⏳곧 마감되는 응모에 참여해보세요!")
                        .font(.infanTitle2)
                        .foregroundColor(.infanBlack)
                        .horizontalPadding()
                    HomeApplyView(applyViewModel: applyViewModel)
                }
                .padding([.top, .bottom])
               
                
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SearchMainView(searchCategory: searchCategory)) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.infanBlack)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("INFANTORY")
                        .font(.infanLogoTitle)
                        .foregroundColor(.infanMain)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                Task {
                    try await searchStore.fetchRandomInfluencer()
                    try await auctionViewModel.fetchAuctionProducts()
                    try await applyViewModel.fetchApplyProducts()
                    applyViewModel.updateFilter(filter: .inProgress)
                    applyViewModel.sortInProgressProduct(filter: .deadline)
                }
            }
            .task {
                Task {
                    try await searchStore.fetchRandomInfluencer()
                    try await auctionViewModel.fetchAuctionProducts()
                    try await applyViewModel.fetchApplyProducts()
                    applyViewModel.updateFilter(filter: .inProgress)
                    applyViewModel.sortInProgressProduct(filter: .deadline)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMainView()
    }
}
