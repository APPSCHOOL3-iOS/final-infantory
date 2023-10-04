//
//  ApplyItemImage.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/04.
//

import SwiftUI

struct ApplyItemImageView: View {
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

struct ApplyItemImage_Previews: PreviewProvider {
    static var previews: some View {
        ApplyItemImageView()
    }
}
