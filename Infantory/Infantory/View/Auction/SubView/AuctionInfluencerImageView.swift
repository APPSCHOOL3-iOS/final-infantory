//
//  AuctionInfluencerImageView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/13/23.
//

import SwiftUI

struct AuctionInfluencerImageView: View {
    
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    var product: AuctionProduct
    
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
                                    
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                    
                                case .failure(_):
                                    Image(systemName: "xmark")
                                        .symbolVariant(.circle.fill)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 100)
                                        .background(Color.infanGray,
                                                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        Text(product.influencerNickname)
                            .font(.infanFootnoteBold)
                        
                    }
                }
            }
            Spacer()
           
            if product.auctionFilter == .planned {
                Text("\(Image(systemName: "timer")) \(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                    .font(.infanFootnote)
                    .foregroundColor(.infanOrange)
            } else {
                TimerView(remainingTime: product.endDate.timeIntervalSince(Date()))
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 6)
        .horizontalPadding()
    }
}
