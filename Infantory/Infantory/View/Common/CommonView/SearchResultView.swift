//
//  SearchResultView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

enum SearchResultCategory: String, CaseIterable {
    case total = "통합검색"
    case influencer = "인플루언서"
    case auction = "경매"
    case apply = "응모"
}

struct SearchResultView: View {
    
    @ObservedObject var searchStore: SearchStore
    @EnvironmentObject var applyViewModel: ApplyProductStore
    @EnvironmentObject var auctionViewModel: AuctionProductViewModel
    @Namespace private var animation
    
    @State var isAnimating: Bool = false
    @Binding var searchText: String
    
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
            
            HStack {
                ForEach(SearchResultCategory.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            searchStore.selectedCategory = category
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
            
            List {
                Section("인플루언서") {
                    ForEach(searchStore.influencer) { influencer in
                        HStack {
                            if influencer.profileImageURLString == nil {
                                Image("Influencer1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                            } else {
                                CachedImage(url: influencer.profileImageURLString ?? "") { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(20)
                                    case .success(let image):
                                        image
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(20)
                                    case .failure:
                                        Image(systemName: "xmark")
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(20)
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            Text(influencer.nickName)
                            Spacer()
                        }
                    }
                    .padding(.top)
                    Divider()
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                Section("경매") {
                    ForEach(searchStore.searchAuctionProduct) { product in
                        Text(product.productName)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                Section("응모") {
                    ForEach(searchStore.searchApplyProduct) { product in
                        Text(product.productName)
//                        ApplyProductListCellView(product: product)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
        }
        .horizontalPadding()
        .onAppear {
            searchStore.findSearchKeyword(keyword: searchText)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchStore: SearchStore(), searchText: .constant("서치텍스트"))
            .environmentObject(ApplyProductStore())
            .environmentObject(AuctionProductViewModel())
    }
}
