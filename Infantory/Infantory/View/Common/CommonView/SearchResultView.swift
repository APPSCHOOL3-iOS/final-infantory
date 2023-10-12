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
    
    @ObservedObject var applyViewModel: ApplyProductStore
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @ObservedObject var searchStore: SearchStore
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
                .horizontalPadding()
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
            .horizontalPadding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("인플루언서").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding(.bottom)
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
                }
                .padding(.top)
                .horizontalPadding()
                Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
                    .overlay {
                        Divider().offset(y: 2.5)
                        Divider().offset(y: -2.5)
                    }
                VStack(alignment: .leading) {
                    Text("경매").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                    ForEach(auctionViewModel.auctionProduct) { product in
                        AuctionProductListCellView(auctionViewModel: auctionViewModel, product: product)
                    }
                }
            
                Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
                    .overlay {
                        Divider().offset(y: 2.5)
                        Divider().offset(y: -2.5)
                    }.offset(y: -10)
                VStack(alignment: .leading) {
                    Text("응모").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
                    ForEach(applyViewModel.applyProduct) { product in
                        ApplyProductListCellView(applyViewModel: applyViewModel, product: product)
                    }
                    
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            searchStore.findSearchKeyword(keyword: searchText)
            applyViewModel.findSearchKeyword(keyword: searchText)
            auctionViewModel.findSearchKeyword(keyword: searchText)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(applyViewModel: ApplyProductStore(), auctionViewModel: AuctionProductViewModel(), searchStore: SearchStore(), searchText: .constant("서치텍스트"))
            .environmentObject(ApplyProductStore())
            .environmentObject(AuctionProductViewModel())
    }
}
