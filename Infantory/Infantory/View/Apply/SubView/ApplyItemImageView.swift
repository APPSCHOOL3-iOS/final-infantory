//
//  ApplyItemImage.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/04.
//

import SwiftUI

struct ApplyItemImageView: View {
    
    var product: ApplyProduct
    
    var body: some View {
        TabView {
            ForEach(product.productImageURLStrings, id: \.self) { url in
                AsyncImage(url: URL(string: url), content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }, placeholder: {
                    ProgressView()
                })
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ApplyItemImage_Previews: PreviewProvider {
    static var previews: some View {
        ApplyItemImageView(product: ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), applyUserIDs: [""]))
            .environmentObject(LoginStore())
    }
}
