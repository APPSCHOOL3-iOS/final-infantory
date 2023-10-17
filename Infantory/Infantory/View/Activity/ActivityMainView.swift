//
//  ActivityMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.

import SwiftUI

struct ActivityMainView: View {
    @State var myAuctionInfos: [AuctionActivityData] = []
    let myAuctionActivityInfos: [AuctionActivityInfo]
    
    @State var myApplyInfos: [ApplyActivityData] = []
    let myApplyActivityInfos: [ApplyActivityInfo]
    
    @State private var selectedFilter: ActivityOption = .auction
    
    let applyStore: ApplyProductStore = ApplyProductStore()
    
    var searchCategory: SearchResultCategory = .total
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    ScrollView {
                        if selectedFilter.title == "경매" {
                            ForEach(myAuctionInfos, id: \.product.id ) { info in
                                NavigationLink {
                                    AuctionDetailView(auctionStore: AuctionStore(product: info.product))
                                } label: {
                                    ActivityRow(product: info.product,
                                                myActivity: info.myPrice,
                                                selectedFilter: $selectedFilter)
                                    .padding()
                                    
                                }
                                .foregroundColor(.black)
                                
                                Divider()
                                
                            }
                        } else {
                            ForEach(myApplyInfos, id: \.product.id) { info in
                                NavigationLink {
                                    ApplyDetailView(applyViewModel: applyStore, product: info.product)
                                } label: {
                                    ActivityRow(product: info.product,
                                                myActivity: info.myApplyCount,
                                                selectedFilter: $selectedFilter)
                                    .padding()
                                }
                                .foregroundColor(.black)
                                
                                Divider()
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
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("활동현황")
                        .font(.infanHeadlineBold)
                }
            }
        }
        .onAppear {
            Task {
                let acticityInfo = ActivityInfo(auctionActivityInfos: myAuctionActivityInfos,
                                                applyActivityInfos: myApplyActivityInfos)
                
                myAuctionInfos = await acticityInfo.getMyAuctionInfos()
                myApplyInfos = await acticityInfo.getMyApplyInfos()
                
                myApplyInfos = Array(Set(myApplyInfos.map { $0.product.id })).compactMap { id in
                    myApplyInfos.first { $0.product.id  == id }
                }
            }
        }
        .refreshable {
            Task {
                let acticityInfo = ActivityInfo(auctionActivityInfos: myAuctionActivityInfos,
                                                applyActivityInfos: myApplyActivityInfos)
                
                myAuctionInfos = await acticityInfo.getMyAuctionInfos()
                myApplyInfos = await acticityInfo.getMyApplyInfos()
                
                myApplyInfos = Array(Set(myApplyInfos.map { $0.product.id })).compactMap { id in
                    myApplyInfos.first { $0.product.id  == id }
                }
            }
        }
    }
}

struct ActivityMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ActivityMainView(myAuctionActivityInfos: [], myApplyActivityInfos: [])
                .environmentObject(LoginStore())
        }
    }
}

struct ActivityRow: View {
    let product: Productable
    let myActivity: Int
    
    @Binding var selectedFilter: ActivityOption
    
    var body: some View {
        HStack {
            CachedImage(url: product.productImageURLStrings[0]) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipShape(Rectangle())
                        .cornerRadius(7)
                    
                case .failure:
                    Image(systemName: "smallAppIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                        .cornerRadius(20)
                    
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(product.productName)")
                        .font(.infanHeadlineBold)
                        .frame(alignment: .leading)
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text(selectedFilter.title == "경매" ? "최고 입찰가 " : "전체 응모수 ")
                    
                    if let auctionProduct = product as? AuctionProduct {
                        Text("\(auctionProduct.winningPrice ?? 0)원")
                            .font(.infanFootnoteBold)
                            .padding(.bottom, 5)
                    } else if let applyProduct = product as? ApplyProduct {
                        Text("\(applyProduct.applyUserIDs.count) 개")
                            .font(.infanFootnoteBold)
                            .padding(.bottom, 5)
                    }
                    
                    Text(selectedFilter.title == "경매" ? "나의 입찰가 " : "사용 응모권 ")
                        .foregroundColor(.infanMain)
                    
                    HStack {
                        Text( "\(myActivity)\(selectedFilter.title == "경매" ? "원" : "회")")
                        
                        Spacer()
                    }
                    .foregroundColor(.infanMain)
                }
            }
            .font(.infanFootnote)
            
            TimerView(remainingTime: product.endDate.timeIntervalSinceNow)
        }
    }
}
