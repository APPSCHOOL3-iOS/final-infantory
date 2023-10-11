//
//  SearchMainView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

struct SearchMainView: View {
        
    @StateObject var searchStore: SearchStore = SearchStore()
    @State private var searchText: String = ""
    @State private var isShowingSearchResult: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                TextField("인플루언서 or 경매/응모 키워드 검색", text: $searchText)
                    .padding(10)
                    .background(Color.infanLightGray.opacity(0.3))
                    .cornerRadius(5)
                    .onSubmit {
                        searchStore.addSearchHistory(keyword: searchText)
                        isShowingSearchResult = true
                    }
                    .submitLabel(.search)
                
                HStack {
                    Text("최근검색어")
                        .bold()
                    Spacer()
                    Button {
                        searchStore.removeAllSearchHistory()
                    } label: {
                        Text("전체삭제")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray)
                    }
                }
                .padding(.top)
            }
            .horizontalPadding()
            
            List {
                ForEach(Array(searchStore.searchArray.reversed()), id: \.self) { keyword in
                    HStack {
                        Image(systemName: "clock")
                        Text(keyword)
                        
                        Spacer()
                        
                        Button {
                            searchStore.removeSelectedSearchHistory(keyword: keyword)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.infanFootnote)
                        }
                        .buttonStyle(.plain)

                    }
                    .onTapGesture {
                        searchText = keyword
                        isShowingSearchResult = true
                    }
                }
                .foregroundColor(.infanDarkGray)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        }
        .navigationDestination(isPresented: $isShowingSearchResult) {
            SearchResultView(searchStore: searchStore, searchText: $searchText)
        }
    }
}

struct SearchMainView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView()
    }
}
