//
//  AuctionItemImage.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/06.
//
//
import SwiftUI

struct AuctionItemImage: View {
    let imageString: [String]
    
    var body: some View {
        TabView {
            ForEach(imageString, id: \.self) { item in
                CachedImage(url: item) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                        
                    case .failure:
                        Image(systemName: "xmark")
                            .symbolVariant(.circle.fill)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(Color.infanGray,
                                        in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    @unknown default:
                        EmptyView()
                    }
                }
                
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct AuctionItemImage_Previews: PreviewProvider {
    static var previews: some View {
        AuctionItemImage(imageString: ["https://firebasestorage.googleapis.com:443/v0/b/infantory-816bc.appspot.com/o/auctionProduct%2FOptional(%227FA489E6-ABA4-4347-8061-91AACED1F733%22)%2FIMG_0002?alt=media&token=cc373ba3-573a-477a-9837-261fd0341e0b"])
    }
}
