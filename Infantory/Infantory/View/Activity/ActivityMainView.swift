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
                                        remainingTime: info.remainingTime, selectedFilter: $selectedFilter)
                            .padding()
                            Divider()
                        }
                    } else {
                        ForEach(myApplyInfos, id: \.productId) { info in
                            ActivityRow(imageURLString: info.imageURLString,
                                        text1: info.totalApplyCount,
                                        text2: info.myApplyCount,
                                        productName: info.productName,
                                        remainingTime: info.remainingTime, selectedFilter: $selectedFilter)
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
                
                //가장 최근에 입찰한 순으로 정렬하고 싶음, 근데 여기서하니까 속도도 느리구
                myAuctionInfos.sort { pro1, pro2 in
                    pro1.timestamp > pro2.timestamp
                }
                print("myAuctionInfos...\(myAuctionInfos)")
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
    let imageURLString: String
    let text1: Int
    let text2: Int
    let productName: String
    let remainingTime: Double
    
    @Binding var selectedFilter: ActivityOption
    
    var body: some View {
        HStack {
            CachedImage(url: imageURLString) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
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
            
            VStack(alignment: .leading) {
                Text("\(productName)")
                    .font(.infanHeadlineBold)
                    .padding(.bottom, 15)
                Group {
                    Text(selectedFilter.title == "경매" ? "\(text1)원" : "전체 응모수 \(text1)회")
                        .font(.infanFootnoteBold)
                        .padding(.bottom, 5)
                        
                    Text(selectedFilter.title == "경매" ? "\(text2)원" : "사용 응모권 \(text2)회")
                        .foregroundColor(.infanGray)
                        .font(.infanFootnote)
                }
            }
            
            Spacer()
            TimerView(remainingTime: remainingTime)
                .frame(width: 100)
                .lineLimit(1)
        }
    }
}
