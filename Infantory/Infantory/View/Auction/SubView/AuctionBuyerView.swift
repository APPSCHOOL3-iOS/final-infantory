//
//  AuctionBuyerView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/28.
//

import SwiftUI

struct AuctionBuyerView: View {
    @State private var currentIndex = 0
    
    @ObservedObject var auctionStore: AuctionStore
    
    var body: some View {
        
        NavigationLink {
            AuctionBuyerDetailView(receivedBiddingData: $auctionStore.biddingInfos)
        } label: {
            HStack {
                HStack {
                    Image("crown")
                    Text("\(auctionStore.biddingInfos.last?.userNickname ?? "")")
                }
                Spacer()
                Text("\(auctionStore.biddingInfos.last?.biddingPrice ?? 0)원")
            }
            .foregroundStyle(.black)
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .fill(Color.infanMain))
        .horizontalPadding()
        .frame(width: CGFloat.screenWidth, height: 80)   
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if currentIndex < 5 {
                    currentIndex += 1
                } else {
                    currentIndex = 0
                }
            }
        }
    }
}

struct AuctionBuyerView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionBuyerView(auctionStore: AuctionStore(product: AuctionProduct.dummyProduct))
    }
}
//#Preview {
//    AuctionBuyerView()
//}
