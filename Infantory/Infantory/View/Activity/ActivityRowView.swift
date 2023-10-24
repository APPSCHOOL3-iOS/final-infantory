//
//  ActivityRowView.swift
//  Infantory
//
//  Created by 이희찬 on 10/24/23.
//

import SwiftUI

struct ActivityRowView: View {
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
        guard let auctionInfos = loginStore.currentUser.auctionActivityInfos, let price = product.winningPrice else { return false }
        return auctionInfos.contains { $0.productId == product.id && $0.price == price }
    }
}
