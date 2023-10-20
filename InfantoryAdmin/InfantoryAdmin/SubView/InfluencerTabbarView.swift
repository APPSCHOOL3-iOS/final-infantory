//
//  InfluencerTabbarView.swift
//  InfantoryAdmin
//
//  Created by 김성훈 on 2023/10/20.
//

import SwiftUI


struct InfluencerTabbarView: View {
    @ObservedObject var influencerManageStore: InfluencerManageStore
    @Binding var category: UserType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(UserType.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            influencerManageStore.selectedCategory = category
                            self.category = category
                            Task {
                                try await influencerManageStore.fetchUsers(type: self.category)
                            }
                        } label: {
                            Text("\(category.asKorean)")
                                .frame(width: UIScreen.main.bounds.width / 4)
                        }
                        .font(.headline)
                        .fontWeight(influencerManageStore.selectedCategory == category ? .bold : .thin)
                        .foregroundColor(.primary)
                        
                        if influencerManageStore.selectedCategory == category {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 2)
                            
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
