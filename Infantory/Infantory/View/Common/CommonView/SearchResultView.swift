//
//  SearchResultView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var applyViewModel: ApplyProductStore
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @ObservedObject var searchStore: SearchStore
    @Namespace private var animation
    
    @State var isAnimating: Bool = false
    @Binding var searchText: String
    @State var searchCategory: SearchResultCategory
    @State private var isShowingToastMessage: Bool = false
    var body: some View {
        VStack {
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
                            SearchResultEmptyView()
                        } else {
                            if searchStore.influencer.count > 0 && searchStore.influencer.count < 6 {
                                SearchTotalCellView(category: "인플루언서", content: SearchInfluencerView(searchStore: searchStore, showCellCount: SearchResultCount.underLimit))
                                SearchRectangleView()
                            } else if searchStore.influencer.count == 0 {
                                EmptyView()
                            } else {
                                SearchTotalCellView(category: "인플루언서", content: SearchInfluencerView(searchStore: searchStore, showCellCount: SearchResultCount.overLimit))
                                .padding(.bottom)
                                SearchMoreItemButtonView(searchStore: searchStore, selectedCategory: .influencer)
                                    .padding()
                                
                                SearchRectangleView()
                            }
                            
                            if auctionViewModel.auctionProduct.count > 0 &&
                                auctionViewModel.auctionProduct.count < 4 {
                                SearchTotalCellView(category: "경매", content: SearchAuctionView(auctionViewModel: auctionViewModel, searchStore: searchStore, showCellCount: SearchResultCount.underLimit))
                                SearchRectangleView().offset(y: -10)
                            } else if auctionViewModel.auctionProduct.count == 0 {
                                EmptyView()
                            } else {
                                SearchTotalCellView(category: "경매", content: SearchAuctionView(auctionViewModel: auctionViewModel, searchStore: searchStore, showCellCount: SearchResultCount.overLimit))
                                SearchMoreItemButtonView(searchStore: searchStore, selectedCategory: .auction)
                                    .padding()
                                
                                SearchRectangleView()
                            }
                            
                            if applyViewModel.applyProduct.count > 0 &&
                                applyViewModel.applyProduct.count < 4 {
                                SearchTotalCellView(category: "응모", content: SearchApplyView(applyViewModel: applyViewModel, searchStore: searchStore, showCellCount: SearchResultCount.underLimit))
                                
                            } else if applyViewModel.applyProduct.count == 0 {
                                EmptyView()
                            } else {
                                SearchTotalCellView(category: "응모", content: SearchApplyView(applyViewModel: applyViewModel, searchStore: searchStore, showCellCount: SearchResultCount.overLimit))
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
                    SearchResultEmptyView()
                } else {
                    Spacer().frame(height: .screenHeight * 0.02)
                    SearchInfluencerView(searchStore: searchStore, showCellCount: SearchResultCount.underLimit)
                }
            case .auction:
                if auctionViewModel.auctionProduct.count == 0 {
                    SearchResultEmptyView()
                } else {
                    SearchAuctionView(auctionViewModel: auctionViewModel, searchStore: searchStore, showCellCount: .underLimit)
                }
            case .apply:
                if applyViewModel.applyProduct.count == 0 {
                    SearchResultEmptyView()
                } else {
                    SearchApplyView(applyViewModel: applyViewModel, searchStore: searchStore, showCellCount: .underLimit)
                }
            }
        }
        .overlay {
            ToastMessage(content: Text("키워드를 입력해주세요."), isPresented: $isShowingToastMessage)
        }
        .onAppear {
            searchStore.selectedCategory = searchCategory
            searchStore.findSearchKeyword(keyword: searchText)
            applyViewModel.findSearchKeyword(keyword: searchText)
            auctionViewModel.findSearchKeyword(keyword: searchText)
        }
        .navigationBar(title: "")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                TextField("인플루언서 or 경매/응모 키워드 검색", text: $searchText)
                    .padding(10)
                    .background(Color.infanLightGray.opacity(0.3))
                    .cornerRadius(5)
                    .onChange(of: searchText, perform: { value in
                        if value.isEmpty {
                            dismiss()
                        }
                    })
                    .onSubmit {
                        if searchText.isEmpty {
                            isShowingToastMessage = true
                            return
                        }
                        searchStore.addSearchHistory(keyword: searchText)
                        searchStore.selectedCategory = searchCategory
                        searchStore.findSearchKeyword(keyword: searchText)
                        applyViewModel.findSearchKeyword(keyword: searchText)
                        auctionViewModel.findSearchKeyword(keyword: searchText)
                    }
                    .submitLabel(.search)
                    .frame(width: .screenWidth - 72)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(applyViewModel: ApplyProductStore(), auctionViewModel: AuctionProductViewModel(), searchStore: SearchStore(), searchText: .constant("서치텍스트"), searchCategory: .total)
    }
}
