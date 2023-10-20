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
    let applyStore: ApplyProductStore = ApplyProductStore()
    
    var searchCategory: SearchResultCategory = .total
    
    var body: some View {
        NavigationStack {
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
                                        ActivityRow(product: info.product,
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
                                        ApplyDetailView(applyViewModel: applyStore, product: info.product)
                                    } label: {
                                        ActivityRow(product: info.product,
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
        .task {
            sortApplyProduct()
        }
        .refreshable {
            sortApplyProduct()
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

struct ActivityRow: View {
    let product: Productable
    
    @Binding var selectedFilter: ActivityOption
    @Binding var isSorted: Bool
    
    var myAuctionInfos: AuctionActivityData?
    var myApplyInfos: ApplyActivityData?
    @EnvironmentObject var loginStore: LoginStore
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    @StateObject var myActivityStore: MyActivityStore = MyActivityStore()
    
    var body: some View {
        HStack {
            CachedImage(url: product.productImageURLStrings[0]) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .cornerRadius(20)
                case .success(let image):
                    if myApplyInfos?.product.applyFilter == .inProgress {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(Rectangle())
                            .cornerRadius(7)
                    } else if myApplyInfos?.product.applyFilter == .close {
                        ZStack {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .blur(radius: 5)
                                .clipShape(Rectangle())
                                .cornerRadius(7)
                            if myApplyInfos?.product.winningUserID == loginStore.currentUser.email {
                                if myApplyInfos?.product.isPaid == true {
                                    Text("결제완료")
                                        .padding(10)
                                        .bold()
                                        .foregroundColor(.white)
                                        .background(Color.infanMain)
                                        .cornerRadius(20)
                                } else {
                                    Text("당첨")
                                        .padding(10)
                                        .bold()
                                        .foregroundColor(.white)
                                        .background(Color.infanMain)
                                        .cornerRadius(20)
                                }
                            } else {
                                Text("미당첨")
                                    .padding(10)
                                    .bold()
                                    .foregroundColor(.white)
                                    .background(Color.infanDarkGray)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    if myAuctionInfos?.product.auctionFilter == .close {
                        ZStack {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .blur(radius: 5)
                                .clipShape(Rectangle())
                                .cornerRadius(7)
                            
                            if isWinner() {
                                if myAuctionInfos?.product.isPaid == true {
                                    Text("결제완료")
                                        .padding(10)
                                        .bold()
                                        .foregroundColor(.white)
                                        .background(Color.infanMain)
                                        .cornerRadius(20)
                                } else {
                                    Text("낙찰")
                                        .padding(10)
                                        .bold()
                                        .foregroundColor(.white)
                                        .background(Color.infanMain)
                                        .cornerRadius(20)
                                }
                                
                            } else {
                                Text("미낙찰")
                                    .padding(10)
                                    .bold()
                                    .foregroundColor(.white)
                                    .background(Color.infanDarkGray)
                                    .cornerRadius(20)
                            }
                        }
                    } else if myAuctionInfos?.product.auctionFilter == .inProgress {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .clipShape(Rectangle())
                            .cornerRadius(7)
                    }
                    
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
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text(selectedFilter.title == "경매" ? "최고 입찰가 " : "전체 응모수 ")
                    
                    if let auctionProduct = product as? AuctionProduct {
                        TextAnimateView(value: myActivityStore.winningPrice)
                            .font(.infanFootnoteBold)
                            .monospacedDigit()
                            .animation(Animation.easeInOut(duration: 1))
                            .padding(.bottom, 5)
                    } else if let applyProduct = product as? ApplyProduct {
                        Text("\(myActivityStore.totalApplyCount) 개")
                            .font(.infanFootnoteBold)
                            .padding(.bottom, 5)
                    }
                    
                    Text(selectedFilter.title == "경매" ? "나의 입찰가 " : "사용 응모권 ")
                        .foregroundColor(.infanMain)
                    
                    if let auctionProduct = product as? AuctionProduct {
                        Text("\(myActivityStore.myBiddingPrice )원")
                            .font(.infanFootnoteBold)
                            .padding(.bottom, 5)
                            .foregroundColor(.infanMain)
                    } else if let applyProduct = product as? ApplyProduct {
                        Text("\(myActivityStore.myApplyCount) 개")
                            .font(.infanFootnoteBold)
                            .padding(.bottom, 5)
                            .foregroundColor(.infanMain)
                    }
                }
            }
            .font(.infanFootnote)
            .foregroundColor(.infanBlack)
            
            TimerView(remainingTime: product.endDate.timeIntervalSinceNow)
        }
        .task {
            let userID = loginStore.currentUser.id ?? ""
            myActivityStore.fetchMyLastBiddingPrice(userID: userID,
                                                    productID: product.id ?? "")
            myActivityStore.fetchWinningPrice(productID: product.id ?? "")
            myActivityStore.fetchApplyCount(userEmail: loginStore.currentUser.email,
                                            productID: product.id ?? "")
            
        }
    }
    
    func isWinner() -> Bool {
        if let activityInfos = loginStore.currentUser.auctionActivityInfos,
            let price = product.winningPrice {
            for info in activityInfos {
                if info.productId == product.id {
                    print(price)
                    print(info.price)
                    return info.price == price
                }
                
            }
        }
        return false
    }
}
