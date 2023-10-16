//
//  HomeBannerView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/15.
//

import SwiftUI

struct HomeBannerView: View {
    
    // 이거 일단.. 따로 뭔가 만들어야 할듯,,,, 일단 아무 이미지나 넣어놓음
    private var product: [String] = ["https://www.denews.co.kr/news/photo/202009/15323_16884_5536.jpg", "https://diamall.co.kr/web/product/tiny/20200206/8d8f437cb7eeed5694944942f4a113d2.jpg"]
    
    var body: some View {
        TabView {
            ForEach(product, id: \.self) { item in
                CachedImage(url: item) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .scaledToFill()
                            .clipped()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    case .failure:
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: .screenWidth - 20, height: .screenWidth - 150)
        .cornerRadius(10)
    }
}

struct HomeBannerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBannerView()
    }
}
