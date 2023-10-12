//
//  ProductCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct ProductListView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(auctionViewModel.filteredProduct) { product in
                    VStack {
                        HStack {
                            if product.influencerProfile == nil {
                                Image("Influencer1")
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
                            
                            Spacer()
//                            TimerView(remainingTime: product.endDate.timeIntervalSince(Date()))
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
                                                    
                                                    Text("응모 종료")
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
                        }
                        .horizontalPadding()
                    }
                }
            }
            
        }
        .onAppear {
            Task {
                do {
                    try await auctionViewModel.fetchAuctionProducts()
                } catch {
                    
                }
            }
        }
    }
}
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductListView(auctionViewModel: AuctionProductViewModel())
                .environmentObject(LoginStore())
        }
    }
}
