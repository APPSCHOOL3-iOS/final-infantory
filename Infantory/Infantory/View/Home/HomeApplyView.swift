//
//  HomeApplyView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/16.
//

import SwiftUI

struct HomeApplyView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(applyViewModel.filteredProduct.prefix(5)) { product in
                    NavigationLink {
                        ApplyDetailView(applyViewModel: applyViewModel, product: product)
                    } label: {
                        VStack(alignment: .leading) {
                                
                                TimerView(remainingTime: applyViewModel.remainingTime(product: product))
                            
                            if product.productImageURLStrings.count > 0 {
                                CachedImage(url: product.productImageURLStrings[0]) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 100) / 2,
                                                   height: (.screenWidth - 100) / 2)
                                            .clipped()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "xmark")
                                            .frame(width: (.screenWidth - 100) / 2,
                                                   height: (.screenWidth - 100) / 2)
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                
                            } else {
                                ZStack(alignment: .topLeading) {
                                    Image("smallAppIcon")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (.screenWidth - 100) / 2,
                                               height: (.screenWidth - 100) / 2)
                                        .clipped()
                                }
                                .padding(8)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(product.influencerNickname)
                                    .bold()
                                Text("전체 응모: \(product.applyUserIDs.count) 회")
                                    .foregroundColor(Color.infanDarkGray)
                            }
                            .font(.infanFootnote)
                            .padding()
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct HomeApplyView_Previews: PreviewProvider {
    static var previews: some View {
        HomeApplyView(applyViewModel: ApplyProductStore())
    }
}
