//
//  InfluencerTabBarView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/18/23.
//

import SwiftUI

struct InfluencerTabBarView: View {
    
    @EnvironmentObject var influencerStore: InfluencerStore
    @Binding var searchCategory: InfluencerCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(InfluencerCategory.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            influencerStore.selectedCategory = category
                            searchCategory = category
                        } label: {
                            Text("\(category.rawValue)")
                                .frame(width: .screenWidth / 2)
                        }
                        .font(.infanHeadline)
                        .fontWeight(influencerStore.selectedCategory == category ? .bold : .thin)
                        .foregroundColor(.primary)
                        
                        if influencerStore.selectedCategory == category {
                            Capsule()
                                .foregroundColor(.infanMain)
                                .frame(height: 2)
                            
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding([.top])
        }
    }
}
