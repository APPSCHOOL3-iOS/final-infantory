//
//  AuctionBuyerView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/28.
//

import SwiftUI

struct AuctionBuyerView: View {
    @State private var currentIndex = 0
    var body: some View {
        
        NavigationLink {
            AuctionBuyerDetailView()
        } label: {
            HStack {
                Text("경매상황 ")
                Spacer()
                Text("123원")
            }
            .foregroundStyle(.black)
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .fill(Color.infanMain))
        .infanHorizontalPadding()
        .frame(width: CGFloat.screenWidth, height: 80)   
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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
        AuctionBuyerView()
    }
}
//#Preview {
//    AuctionBuyerView()
//}
