//
//  InfluencerView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

struct InfluencerView: View {
    
    @StateObject private var influencerManageStore: InfluencerManageStore = InfluencerManageStore()
    @State private var category: UserType = .user
    var body: some View {
        VStack {
            InfluencerTabbarView(influencerManageStore: influencerManageStore, category: $category)
            ScrollView {
                VStack {
                    ForEach(influencerManageStore.users) { user in
                        HStack {
                            HStack {
                                Text(user.nickName)
                                Text(user.phoneNumber)
                                Text("\(user.isInfluencer.asKorean)")
                                
                                if user.isInfluencer == .user {
                                    Button {
                                        Task {
                                            guard let id = user.id else { return }
                                            try await influencerManageStore.updateUserToInfluencer(userId: id)
                                        }
                                    } label: {
                                        Text("인플루언서로 변경")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .task {
            Task {
                try await influencerManageStore.fetchUsers(type: influencerManageStore.selectedCategory)
            }
        }
    }
}


