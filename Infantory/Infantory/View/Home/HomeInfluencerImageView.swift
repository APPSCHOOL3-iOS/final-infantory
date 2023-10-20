//
//  HomeInfluencerImageView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/15.
//

import SwiftUI

struct HomeInfluencerImageView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    @ObservedObject var searchStore: SearchStore
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(searchStore.influencer.prefix(10)) { influencer in
                    NavigationLink {
                        InfluencerMainView(influencerID: influencer.id ?? "")
                    } label: {
                        VStack(spacing: 8) {
                            CachedImage(url: influencer.profileImageURLString ?? "") { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(40)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(40)
                                case .failure:
                                    Image("smallAppIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(40)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            Text(influencer.nickName)
                                .font(.infanFootnote)
                                .foregroundColor(.infanBlack)
                        }
                        .padding(.leading, 20)
                    }
                }
            }
        }
        .frame(height: 90)
        .scrollIndicators(.hidden)
    }
}

struct HomeInfluencerImageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeInfluencerImageView(applyViewModel: ApplyProductStore(), searchStore: SearchStore())
    }
}
