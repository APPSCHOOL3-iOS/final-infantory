//
//  AuctionInfluencerImageView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/13/23.
//

import SwiftUI

struct AuctionInfluencerImageView: View {
    
    var product: AuctionProduct
    
    var body: some View {
        HStack {
            NavigationLink {
                InfluencerMainView(influencerID: product.influencerID)
            } label: {
                HStack {
                    CachedImage(url: product.influencerProfile ?? "") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            
                        case .failure:
                            Image("smallAppIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                        @unknown default:
                            
                            EmptyView()
                        }
                    }
                    Text(product.influencerNickname)
                        .foregroundColor(.infanBlack)
                        .font(.infanFootnoteBold)
                }
            }
            
        }
        .padding(.top, 10)
        .padding(.bottom, 6)
    }
}
