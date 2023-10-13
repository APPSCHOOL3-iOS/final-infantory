//
//  AuctionProductListCellView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/12/23.
//

import SwiftUI

struct AuctionProductListCellView: View {
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    var product: AuctionProduct
    
    var body: some View {
        VStack {
            HStack {
                if product.influencerProfile == nil {
                    Image("Influencer1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                } else {
                    CachedImage(url: product.influencerProfile ?? "https://media.bunjang.co.kr/product/233471258_1_1692280086_w%7Bres%7D.jpg") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                        case .success(let image):
                            image
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            
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
                    .font(.infanFootnoteBold)
            
                Spacer()

                if product.auctionFilter == .planned {
                    Text("\(Image(systemName: "timer")) \(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                        .font(.infanFootnote)
                        .foregroundColor(.infanOrange)
                } else {
                    TimerView(remainingTime: product.endDate.timeIntervalSince(Date()))
                }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 6)
        .horizontalPadding()
        
        NavigationLink {
            AuctionDetailView(auctionProductViewModel: auctionViewModel, auctionStore: AuctionStore(product: product))
        } label: {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
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
                                if product.auctionFilter == .close {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .blur(radius: 5)
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
                                        
                                        Text("경매 종료")
                                            .padding(10)
                                            .bold()
                                            .foregroundColor(.white)
                                            .background(Color.infanDarkGray)
                                            .cornerRadius(20)
                                    }
                                } else if product.auctionFilter == .planned {
                                    ZStack {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .blur(radius: 5)
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
                                        
                                        Text("응모 예정")
                                            .padding(10)
                                            .bold()
                                            .foregroundColor(.white)
                                            .background(Color.infanOrange)
                                            .cornerRadius(20)
                                    }
                                } else {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                        .clipped()
                                }
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
                            
                            Image("appleLogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: (.screenWidth - 100) / 2,
                                       height: (.screenWidth - 100) / 2)
                                .clipped()
                            
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("\(product.productName)")
                            .font(.infanBody)
                            .foregroundColor(.infanDarkGray)
                            .multilineTextAlignment(.leading)
                        
                        Text("\(product.winningPrice ?? 0)원")
                            .font(.infanHeadlineBold)
                            .foregroundColor(.infanDarkGray)
                        
                        Spacer()
                        VStack {
                            Text("시작일  \(InfanDateFormatter.shared.dateTimeString(from: product.startDate))")
                                .font(.infanFootnote)
                                .foregroundColor(.infanGray)
                            
                            Text("마감일  \(InfanDateFormatter.shared.dateTimeString(from: product.endDate))")
                                .font(.infanFootnote)
                                .foregroundColor(.infanGray)
                        }
                    }
                    Spacer()
                }
                Divider()
            }
            .horizontalPadding()
        }
    }
}

struct AuctionProductListCellView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionProductListCellView(auctionViewModel: AuctionProductViewModel(), product: AuctionProduct(id: "", productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "", influencerProfile: "", winningUserID: "", startDate: Date(), endDate: Date(), minPrice: 0, winningPrice: 0))
    }
}
