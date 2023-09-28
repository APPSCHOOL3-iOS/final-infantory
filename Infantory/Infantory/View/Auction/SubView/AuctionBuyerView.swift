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
        NavigationStack {
                TabView(selection: $currentIndex) {
                    ForEach(0..<5) { item in
                        NavigationLink {
                            AuctionBuyerDetailView()
                        } label: {
                            HStack {
                                Text("경매상황 ")
                                Spacer()
                                Text("홍길동 \(item)원")
                            }
                            .foregroundStyle(.black)
                            .padding()
                        }
                    }
                }
                .background(
                    Rectangle()
                        .stroke(lineWidth: 1)
                        .background(Color.infanMain))
                .frame(width: CGFloat.screenWidth, height: 80)
                .tabViewStyle(PageTabViewStyle())
        }
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

#Preview {
    AuctionBuyerView()
}
