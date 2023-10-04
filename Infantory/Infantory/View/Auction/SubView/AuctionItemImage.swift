//
//  AuctionItemImge.swift
//  Infantory
//
//  Created by 변상필 on 10/3/23.
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

