//
//  ActivityMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct ActivityMainView: View {
    @State var myAuctionInfos: [AuctionActivityData] = []
    let myAuctionActivityInfos: [AuctionActivityInfo]
    
    @State var myApplyInfos: [ApplyActivityData] = []
    let myApplyActivityInfos: [ApplyActivityInfo]
    
    @State private var selectedFilter: ActivityOption = .auction
    
    var body: some View {
        VStack {
            Section {
                ScrollView {
                    if selectedFilter.title == "경매" {
                        ForEach(myAuctionInfos, id: \.productId ) { info in
                            ActivityRow(imageURLString: info.imageURLString,
                                        text1: info.winningPrice,
                                        text2: info.price,
                                        productName: info.productName,
                                        remainingTime: info.remainingTime)
                            .padding()
                            Divider()
                        }
                    } else {
                        ForEach(myApplyInfos, id: \.productId) { info in
                            ActivityRow(imageURLString: info.imageURLString,
                                        text1: info.totalApplyCount,
                                        text2: info.myApplyCount,
                                        productName: info.productName,
                                        remainingTime: info.remainingTime)
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
            Task {
                let acticityInfo = ActivityInfo(auctionActivityInfos: myAuctionActivityInfos,
                                                applyActivityInfos: myApplyActivityInfos)
                
                myAuctionInfos = await acticityInfo.getMyAuctionInfos()
                myApplyInfos = await acticityInfo.getMyApplyInfos()
            }
        }
    }
}

struct ActivityMainView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMainView(myAuctionActivityInfos: [], myApplyActivityInfos: [])
            .environmentObject(LoginStore())
    }
}

struct ActivityRow: View {
    let imageURLString: String
    let text1: Int
    let text2: Int
    let productName: String
    let remainingTime: Double
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageURLString)!) { image in
                image.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }
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
