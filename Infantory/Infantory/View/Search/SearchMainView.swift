//
//  SearchMainView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

struct SearchMainView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var searchStore: SearchStore = SearchStore()
    @StateObject var applyProductStore: ApplyProductStore = ApplyProductStore()
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    @State private var searchText: String = ""
    @State private var isShowingSearchResult: Bool = false
    @State private var isShowingToastMessage: Bool = false
    var searchCategory: SearchResultCategory
    @FocusState private var focus: String?
    
    var body: some View {
        VStack {
            VStack {
                
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
            .overlay {
                ToastMessage(content: Text("키워드를 입력해주세요."), isPresented: $isShowingToastMessage)
            }
            
        }
        .navigationDestination(isPresented: $isShowingSearchResult) {
            SearchResultView(applyProductStore: applyProductStore, auctionViewModel: auctionViewModel, searchStore: searchStore, searchText: $searchText, searchCategory: searchCategory)
        }
        .navigationBar(title: "")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                TextField("인플루언서 or 경매/응모 키워드 검색", text: $searchText)
                    .padding(10)
                    .background(Color.infanLightGray.opacity(0.3))
                    .cornerRadius(5)
                    .onSubmit {
                        if searchText.isEmpty {
                            isShowingToastMessage = true
                            return
                        }
                        searchStore.addSearchHistory(keyword: searchText)
                        isShowingSearchResult = true
                    }
                    .focused($focus, equals: searchText)
                    .submitLabel(.search)
                    .frame(width: .screenWidth - 72)
            }
        }
        .task {
            focus = searchText
        }
    }
}

struct SearchMainView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView(applyProductStore: ApplyProductStore(), searchCategory: .total)
    
    }
}
