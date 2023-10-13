//
//  SearchResultView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

struct SearchResultView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @ObservedObject var searchStore: SearchStore
    @Namespace private var animation
    
    @State var isAnimating: Bool = false
    @Binding var searchText: String
    @State var searchCategory: SearchResultCategory
    
    var body: some View {
        VStack {
            TextField("인플루언서 or 경매/응모 키워드 검색", text: $searchText)
                .padding(10)
                .background(Color.infanLightGray.opacity(0.3))
                .cornerRadius(5)
                .onSubmit {
                    searchStore.addSearchHistory(keyword: searchText)
                }
                .submitLabel(.search)
                .horizontalPadding()
            HStack {
                ForEach(SearchResultCategory.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            searchStore.selectedCategory = category
                            searchCategory = category
                        } label: {
                            Text("\(category.rawValue)")
                                .frame(width: UIScreen.main.bounds.width / 4.5)
                        }
                        .font(.infanHeadline)
                        .fontWeight(searchStore.selectedCategory == category ? .bold : .thin)
                        .foregroundColor(.primary)
                        
                        if searchStore.selectedCategory == category {
                            Capsule()
                                .foregroundColor(.infanMain)
                                .frame(height: 2)
                            
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding([.top])
            .horizontalPadding()
            
            switch searchStore.selectedCategory {
            case .total:
                ScrollView {
                    VStack {
                        if searchStore.influencer.count == 0 && auctionViewModel.auctionProduct.count == 0 && applyViewModel.applyProduct.count == 0 {
                            Spacer().frame(height: .screenHeight * 0.03)
                            Text("검색된 결과가 없습니다.")
                        } else {
                            if searchStore.influencer.count < 6 {
                                VStack(alignment: .leading) {
                                    Text("인플루언서").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                                    SearchInfluencerView(searchStore: searchStore, showCellCount: SearchResultCount.underLimit)
                                }
                                Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
                                    .overlay {
                                        Divider().offset(y: 2.5)
                                        Divider().offset(y: -2.5)
                                    }
                            } else {
                                VStack(alignment: .leading) {
                                    Text("인플루언서").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                                    SearchInfluencerView(searchStore: searchStore, showCellCount: SearchResultCount.overLimit)
                                    
                                }
                                SearchMoreItemButtonView(searchStore: searchStore, selectedCategory: .influencer)
                                    .padding()
                                
                                Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
                                    .overlay {
                                        Divider().offset(y: 2.5)
                                        Divider().offset(y: -2.5)
                                    }
                            }
                            
                            if auctionViewModel.auctionProduct.count < 4 {
                                VStack(alignment: .leading) {
                                    Text("경매").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                                    SearchAuctionView(auctionViewModel: auctionViewModel, searchStore: searchStore, showCellCount: SearchResultCount.underLimit)
                                }
                                Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
                                    .overlay {
                                        Divider().offset(y: 2.5)
                                        Divider().offset(y: -2.5)
                                    }.offset(y: -10)
                            } else {
                                VStack(alignment: .leading) {
                                    Text("경매").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                                    SearchAuctionView(auctionViewModel: auctionViewModel, searchStore: searchStore, showCellCount: SearchResultCount.overLimit)
                                    
                                }
                                SearchMoreItemButtonView(searchStore: searchStore, selectedCategory: .auction)
                                    .padding()
                                
                                Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
                                    .overlay {
                                        Divider().offset(y: 2.5)
                                        Divider().offset(y: -2.5)
                                    }
                            }
                            
                            if applyViewModel.applyProduct.count < 4 {
                                VStack(alignment: .leading) {
                                    Text("응모").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                                    SearchApplyView(applyViewModel: applyViewModel, searchStore: searchStore, showCellCount: SearchResultCount.underLimit)
                                }
                                
                            } else {
                                VStack(alignment: .leading) {
                                    Text("응모").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                                    SearchApplyView(applyViewModel: applyViewModel, searchStore: searchStore, showCellCount: SearchResultCount.overLimit)
                                    
                                }
                                VStack {
                                    SearchMoreItemButtonView(searchStore: searchStore, selectedCategory: .apply)
                                        .padding()
                                }
                                .padding(.bottom)
                            }
                        }
                    }
                }
                .padding(.bottom, 1)
            case .influencer:
                if searchStore.influencer.count == 0 {
                    Spacer().frame(height: .screenHeight * 0.03)
                    Text("검색된 결과가 없습니다.")
                } else {
                    Spacer().frame(height: .screenHeight * 0.01)
                    SearchInfluencerView(searchStore: searchStore, showCellCount: SearchResultCount.underLimit)
                }
            case .auction:
                if auctionViewModel.auctionProduct.count == 0 {
                    Spacer().frame(height: .screenHeight * 0.03)
                    Text("검색된 결과가 없습니다.")
                } else {
                    SearchAuctionView(auctionViewModel: auctionViewModel, searchStore: searchStore, showCellCount: .underLimit)
                }
            case .apply:
                if applyViewModel.applyProduct.count == 0 {
                    Spacer().frame(height: .screenHeight * 0.03)
                    Text("검색된 결과가 없습니다.")
                } else {
                    SearchApplyView(applyViewModel: applyViewModel, searchStore: searchStore, showCellCount: .underLimit)
                }
            }
        }
        .onAppear {
            searchStore.selectedCategory = searchCategory
            searchStore.findSearchKeyword(keyword: searchText)
            applyViewModel.findSearchKeyword(keyword: searchText)
            auctionViewModel.findSearchKeyword(keyword: searchText)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(applyViewModel: ApplyProductStore(), auctionViewModel: AuctionProductViewModel(), searchStore: SearchStore(), searchText: .constant("서치텍스트"), searchCategory: .total)
    }
}
