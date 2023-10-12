//
//  ActivityMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct ActivityMainView: View {
    @ObservedObject var activityStore: ActivityStore = ActivityStore()
    //    @ObservedObject var auctionStore: AuctionStore
    
    @EnvironmentObject var loginStore: LoginStore
    
    @State private var selectedFilter: ActivityOption = .auction
    
    let auctionProducts: [AuctionProduct]
    let auctionActivityInfos: [AuctionActivityInfo]
    
    var body: some View {
        VStack {
            Section {
                ScrollView {
                    if selectedFilter.title == "경매" {
                        Text("\(activityStore.auctionActivityDatas.count)")
                        ForEach(activityStore.auctionActivityDatas, id: \.productId ) { activityData in
                            ActivityRow(imageURLString: activityData.imageURLString,
                                        text1: activityData.winningPrice,
                                        text2: activityData.price,
                                        productName: activityData.productName,
                                        remainingTime: activityData.remainingTime)
                            .padding()
                            Divider()
                        }
                    } else {
                        ForEach(activityStore.applyActivityDatas, id: \.productId) { activityData in
                            ActivityRow(imageURLString: activityData.imageURLString,
                                        text1: activityData.totalApplyCount,
                                        text2: activityData.myApplyCount,
                                        productName: activityData.productName,
                                        remainingTime: activityData.remainingTime)
                            .padding()
                            Divider()
                        }
                        
                    }
                }
            } header: {
                ActivityOptionBar(selectedFilter: $selectedFilter)
            }
        }
        .onAppear {
            activityStore.fetchMyAuctionProducts(auctionProducts: auctionProducts, auctionActivityInfos: auctionActivityInfos)
        }
    }
}

struct ActivityMainView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMainView(auctionProducts: [], auctionActivityInfos: [])
            .environmentObject(LoginStore())
    }
}

struct ActivityRow: View {
    let imageURLString: [String]
    let text1: Int
    let text2: Int
    let productName: String
    let remainingTime: Double
    
    var body: some View {
        HStack {
//            AsyncImage(url: URL(string: imageURLString[0])!) { image in
//                image.image?
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50)
//            }
            Text("\(productName)")
                .frame(width: 80)
            
            VStack {
                Text("\(text1)")
                    .font(.infanFootnoteBold)
                    .padding()
                Text("\(text2)")
                    .foregroundColor(.infanGray)
                    .font(.infanFootnote)
            }
            
            Spacer()
            TimerView(remainingTime: remainingTime)
                .frame(width: 100)
        }
    }
}
