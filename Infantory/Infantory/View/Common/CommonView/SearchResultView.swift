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
                        
                        Text("\(category.rawValue)")
                            .font(.infanHeadline)
                            .foregroundColor(searchStore.selectedCategory == category ? .black: .gray)
                            .frame(maxWidth: .infinity)
                        
                        if searchStore.selectedCategory == category {
                            Capsule()
                                .foregroundColor(.infanDarkGray)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "info", in: animation)
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            searchStore.selectedCategory = category
                        }
                    }
                }
            }
            .padding(.top)
            
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
                                AsyncImage(url: URL(string: influencer.profileImageURLString ?? ""), content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                }, placeholder: {
                                    ProgressView()
                                })
                            }
                            Text(influencer.name) // 닉네임으로 바꾸기
                            Spacer()
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .offset(x: -20, y: -20)
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
    }
}
