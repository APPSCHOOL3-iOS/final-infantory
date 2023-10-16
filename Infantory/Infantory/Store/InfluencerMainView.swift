//
//  InfluencerMainView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/16/23.
//

import SwiftUI

struct InfluencerMainView: View {
    
    @EnvironmentObject var influencerStore: InfluencerStore
    var influencerID: String
    
    var body: some View {
        ScrollView {
            VStack {
                InfluencerImageView()
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.infanMain)
                        .cornerRadius(8)
                        .overlay {
                            Text("팔로우")
                                .foregroundColor(.white)
                                .font(.infanHeadline)
                                .padding()
                        }
                        .frame(width: .screenWidth - 40, height: 40)
                }
                
            }
        }
        .navigationBar(title: influencerStore.influencer.nickName)
        .onAppear {
            Task {
                try await influencerStore.fetchInfluencer(influencerID: influencerID)
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
