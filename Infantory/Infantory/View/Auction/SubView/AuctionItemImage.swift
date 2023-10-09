//
//  AuctionItemImage.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/06.
//
//
import SwiftUI

struct AuctionItemImage: View {
    var body: some View {
        TabView {
            ForEach(0..<5) { _ in
                Image("Influencer1")
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct AuctionItemImage_Previews: PreviewProvider {
    static var previews: some View {
        AuctionItemImage()
    }
}
