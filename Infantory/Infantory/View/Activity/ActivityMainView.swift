//
//  ActivityMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct ActivityMainView: View {
    
    @ObservedObject var auctionStore: AuctionStore
    @EnvironmentObject var loginStore: LoginStore
    
    let imageURLString: String = "https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000401.png"
    let productName: String = "신발"
    
    var body: some View {
        VStack {
            ActivityOptionBar()
            ScrollView {
                ForEach(0..<10) { _ in
                    activityRowView
                        .padding()
                    Divider()
                }
            }
            
        }
        
    }
}

struct ActivityMainView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMainView(auctionStore: AuctionStore(product: AuctionProduct.dummyProduct))
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
            
            VStack {
                Text("\(auctionStore.biddingInfos.last?.biddingPrice ?? 0)")
                Text("")
            }
            Spacer()
            TimerView(remainingTime: auctionStore.remainingTime)
        }
    }
}
