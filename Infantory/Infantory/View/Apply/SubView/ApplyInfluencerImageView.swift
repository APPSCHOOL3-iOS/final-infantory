//
//  ApplyInfluencerImageView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/13/23.
//

import SwiftUI

struct ApplyInfluencerImageView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    var product: ApplyProduct
    
    var body: some View {
        HStack {
            NavigationLink {
                Text("아무거나")
            } label: {
                VStack {
                    HStack {
                        if product.influencerProfile == nil {
                            Image("smallAppIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            
                        } else {
                            CachedImage(url: product.influencerProfile ?? "") { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                    //
                                case .failure:
                                    Image(systemName: "xmark")
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                    
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        Text(product.influencerNickname)
                            .foregroundColor(.black)
                            .font(.infanFootnoteBold)
                            
                    }
                    
                }
            }
            Spacer()
            
            if product.applyFilter == .planned {
                Text("\(Image(systemName: "timer")) \(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                    .font(.infanFootnote)
                    .foregroundColor(.infanOrange)
            } else {
                TimerView(remainingTime: applyViewModel.remainingTime(product: product))
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 6)
        .horizontalPadding()
    }
}
