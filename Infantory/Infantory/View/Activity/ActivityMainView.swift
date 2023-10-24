//
//  ActivityMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.

import SwiftUI

struct ActivityMainView: View {
    @EnvironmentObject var loginStore: LoginStore
    @State private var selectedFilter: ActivityOption = .auction
    @State private var isSorted: Bool = false
    @State var myAuctionInfos: [AuctionActivityData] = []
    @State var myApplyInfos: [ApplyActivityData] = []
    @State var isShowingLoginSheet: Bool = false
    let applyStore: ApplyProductStore = ApplyProductStore()
    
    var searchCategory: SearchResultCategory = .total
    
    var body: some View {
        NavigationStack {
            if loginStore.userUid.isEmpty {
                Button {
                    isShowingLoginSheet = true
                } label: {
                    Text("로그인")
                        .bold()
                }
            } else {
                VStack {
                    
                    Section {
                        if selectedFilter.title == "경매" {
                            if myAuctionInfos.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("참여한 경매가 없습니다.")
                                        .font(.infanBody)
                                        .foregroundColor(.infanGray)
                                    Spacer()
                                }
                            } else {
                                ScrollView {
                                    ForEach(myAuctionInfos, id: \.product.id ) { info in
                                        NavigationLink {
                                            AuctionDetailView(auctionStore: AuctionStore(product: info.product))
                                        } label: {
                                            ActivityRowView(product: info.product,
                                                        selectedFilter: $selectedFilter, isSorted: $isSorted,
                                                        myAuctionInfos: info)
                                            .padding()
                                        }
                                        .foregroundColor(.black)
                                        
                                        Divider()
                                    }
                                }
                                
                            }
                        } else {
                            if myApplyInfos.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("참여한 응모가 없습니다.")
                                        .font(.infanBody)
                                        .foregroundColor(.infanGray)
                                    Spacer()
                                }
                            } else {
                                ScrollView {
                                    ForEach(myApplyInfos, id: \.product.id) { info in
                                        NavigationLink {
                                            ApplyDetailView(applyProductStore: applyStore, product: info.product)
                                        } label: {
                                            ActivityRowView(product: info.product,
                                                        selectedFilter: $selectedFilter, isSorted: $isSorted, myApplyInfos: info)
                                            .padding()
                                        }
                                        .foregroundColor(.black)
                                        
                                        Divider()
                                    }
                                }
                            }
                            
                        }
                        
                    } header: {
                        ActivityOptionBar(selectedFilter: $selectedFilter)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SearchMainView(searchCategory: searchCategory)) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.infanBlack)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("활동현황")
                            .font(.infanHeadlineBold)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingLoginSheet) {
            LoginSheetView()
                .environmentObject(loginStore)
        }
        .task {
            if !loginStore.userUid.isEmpty {
                sortApplyProduct()
            }
        }
        .refreshable {
            if !loginStore.userUid.isEmpty {
                sortApplyProduct()
            }
        }
    }
    func sortApplyProduct() {
        Task {
            let activityStore = ActivityStore(loginStore: loginStore)
            self.loginStore.currentUser.applyActivityInfos?.sort {
                $0.timestamp < $1.timestamp
            }
            
            myAuctionInfos = await activityStore.getMyAuctionInfos()
            myApplyInfos = await activityStore.getMyApplyInfos()
            myApplyInfos = Array(Set(myApplyInfos.map { $0.product.id })).compactMap { id in
                myApplyInfos.reversed().first { $0.product.id  == id }
            }
            myAuctionInfos.sort {
                $0.timeStamp > $1.timeStamp
            }
            myApplyInfos.sort {
                return $0.timeStamp > $1.timeStamp
            }
        }
    }
}

struct ActivityMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ActivityMainView()
                .environmentObject(LoginStore())
        }
    }
}
