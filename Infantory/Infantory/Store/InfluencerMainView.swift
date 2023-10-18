//
//  InfluencerMainView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/16/23.
//

import SwiftUI

struct InfluencerMainView: View {
    
    @EnvironmentObject var influencerStore: InfluencerStore
    @StateObject var applyViewModel: ApplyProductStore = ApplyProductStore()
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    
    var influencerID: String
    @State var searchCategory: InfluencerCategory = .auction
    var isFollow: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                InfluencerImageView()
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isFollow ? Color.infanLightGray: Color.infanMain)
                        .cornerRadius(8)
                        .overlay {
                            Text(isFollow ? "팔로우 취소": "팔로우")
                                .foregroundColor(.white)
                                .font(.infanHeadline)
                                .padding()
                        }
                        .frame(width: .screenWidth - 40, height: 40)
                }
                
                InfluencerTabBarView(searchCategory: $searchCategory)
                InfluencerApplyListView(applyViewModel: applyViewModel)
            }
        }
        .navigationBar(title: influencerStore.influencer.nickName)
        .task {
            Task {
                try await influencerStore.fetchInfluencer(influencerID: influencerID)
                try await influencerStore.fetchInfluencerApplyProduct(influencerID: influencerID)
            }
        }
        .refreshable {
            Task {
                try await influencerStore.fetchInfluencer(influencerID: influencerID)
            }
        }
    }
}

struct InfluencerMainView_Previews: PreviewProvider {
    static var previews: some View {
        InfluencerMainView(influencerID: "")
    }
}
