//
//  ActivityMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct ActivityMainView: View {
    
    @ObservedObject var auctionStore: AuctionStore
    @ObservedObject var applyProductStore: ApplyProductStore
    @EnvironmentObject var loginStore: LoginStore
    
    @State private var selectedFilter: ActivityOption = .auction
    
    let imageURLString: String = "https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000401.png"
    let productName: String = "신발"
    
    var body: some View {
        VStack {
            Section {
                if selectedFilter.title == "경매" {
                    ScrollView {
                        ForEach(0..<10) { _ in
                            activityRowView
                                .padding()
                            Divider()
                        }
                    }
                } else {
                    ScrollView {
                        ForEach(0..<10) { _ in
                            applyRowView
                                .padding()
                            Divider()
                        }
                    }
                    
                }
            } header: {
                ActivityOptionBar(selectedFilter: $selectedFilter)
            }
        }
    }
}

struct ActivityMainView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMainView(auctionStore: AuctionStore(product: AuctionProduct.dummyProduct), applyProductStore: ApplyProductStore())
            .environmentObject(LoginStore())
    }
}

extension ActivityMainView {
    var activityRowView: some View {
        
        HStack {
            AsyncImage(url: URL(string: imageURLString)!) { image in
                image.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }
            Text("\(auctionStore.product.productName)")
                .frame(width: 80)
                   
            VStack {
                Text("\(auctionStore.biddingInfos.last?.biddingPrice ?? 0)원")
                    .font(.infanFootnoteBold)
                    .padding()
                Text("36800원")
                    .foregroundColor(.infanGray)
                    .font(.infanFootnote)
            }
            
            Spacer()
            TimerView(remainingTime: auctionStore.remainingTime)
                .frame(width: 100)
        }
    }
    
    var applyRowView: some View {
        
        HStack {
            AsyncImage(url: URL(string: imageURLString)!) { image in
                image.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }
            Text("\(auctionStore.product.productName)")
                .frame(width: 80)
                   
            VStack {
                Text("현재 응모된 티켓")
                    .font(.infanFootnoteBold)
                    .padding()
                Text("내가 쓴 티켓")
                    .foregroundColor(.infanGray)
                    .font(.infanFootnote)
            }
            
            Spacer()
            TimerView(remainingTime: auctionStore.remainingTime)
                .frame(width: 100)
        }
    }
}
