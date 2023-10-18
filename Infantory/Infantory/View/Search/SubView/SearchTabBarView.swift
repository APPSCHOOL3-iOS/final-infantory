//
//  TabBarView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/18/23.
//

import SwiftUI

struct SearchTabBarView: View {
    @ObservedObject var searchStore: SearchStore
    @Binding var searchCategory: SearchResultCategory
    var body: some View {
        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(SearchResultCategory.allCases, id: \.self) { category in
                        VStack {
                            Button {                   
                                    searchStore.selectedCategory = category
                                    searchCategory = category
                            } label: {
                                Text("\(category.rawValue)")
                                    .frame(width: .screenWidth / 4.7)
                            }
                            .font(.infanHeadline)
                            .fontWeight(searchStore.selectedCategory == category ? .bold : .thin)
                            .foregroundColor(.primary)
                            
                            if searchStore.selectedCategory == category {
                                
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
                .horizontalPadding()
            }
    }
}
