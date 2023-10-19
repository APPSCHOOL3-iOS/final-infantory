//
//  InfluencerImageView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/16/23.
//

import SwiftUI

struct InfluencerImageView: View {
    
    @EnvironmentObject var influencerStore: InfluencerStore

    var body: some View {
        HStack(spacing: 50) {
            VStack(alignment: .leading) {
                if influencerStore.influencer.profileImageURLString == nil {
                    Image("smallAppIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .cornerRadius(45)
                } else {
                    CachedImage(url: influencerStore.influencer.profileImageURLString ?? "") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .cornerRadius(45)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .cornerRadius(45)
                        case .failure:
                            Image(systemName: "xmark")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .cornerRadius(45)
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                Text("\(influencerStore.influencer.name)")
                    .font(.infanHeadlineBold)
                    .foregroundColor(.infanBlack)
            }
            VStack {
                Text("\(influencerStore.influencerAuctionProduct.count)")
                    .font(.infanHeadlineBold)
                Text("경매품")
                    .font(.infanFootnote)
            }
            .foregroundColor(.infanBlack)
            
            VStack {
                Text("\(influencerStore.influencerApplyProduct.count)")
                    .font(.infanHeadlineBold)
                Text("응모품")
                    .font(.infanFootnote)
            }
            .foregroundColor(.infanBlack)
            
            VStack {
                Text("\(influencerStore.followCount)").font(.infanHeadlineBold)
                Text("팔로워")
                    .font(.infanFootnote)
            }
            .foregroundColor(.infanBlack)
        }
        .padding()
    }
}
