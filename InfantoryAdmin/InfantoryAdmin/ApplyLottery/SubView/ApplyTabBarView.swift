//
//  ApplyTabBarView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/19/23.
//

import SwiftUI

struct ApplyTabBarView: View {
    
    @ObservedObject var applyLotteryStore: ApplyLotteryStore
    @Binding var closeCategory: ApplyCloseFilter
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(ApplyCloseFilter.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            applyLotteryStore.selectedCatogory = category
                            closeCategory = category
                        } label: {
                            Text("\(category.rawValue)")
                                .frame(width: UIScreen.main.bounds.width / 4)
                        }
                        .font(.headline)
                        .fontWeight(applyLotteryStore.selectedCatogory == category ? .bold : .thin)
                        .foregroundColor(.primary)
                        
                        if applyLotteryStore.selectedCatogory == category {
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

