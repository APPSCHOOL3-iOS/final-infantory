//
//  ProductCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var auctionViewModel: AuctionProductViewModel
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(auctionViewModel.auctionProduct) { product in
                    
                    VStack {
                        HStack {
                            Image("Influencer1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            
                            Text("\(userViewModel.user.name)")
                                .font(.infanFootnoteBold)
                            
                            Spacer()
                            Label("03:22:15", systemImage: "timer")
                                .foregroundColor(.infanMain)
                                .font(.infanFootnote)
                                .frame(height: 24)
                                .padding(4)

                        }
                        .infanHorizontalPadding()
                        
                        NavigationLink {
                            AuctionDetailView(userViewModel: userViewModel, auctionProductViewModel: auctionViewModel)
                        } label: {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 16) {
                                    if product.productImageURLStrings.count > 0 {
                                        if let url = URL(string: product.productImageURLStrings[0]) {
                                            AsyncImage(url: url) { image in
                                                
                                                ZStack(alignment: .topLeading) {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: (.screenWidth - 60) / 2, height: (.screenWidth - 60) / 2)
                                                        .cornerRadius(4)
                                                        .clipped()
                                                    
                                                }
                                            } placeholder: {
                                                ProgressView()
                                                    .scaledToFill()
                                                    .frame(width: (.screenWidth - 60) / 2, height: (.screenWidth - 60) / 2)
                                                    .cornerRadius(4)
                                                    .clipped()
                                            }
                                        }
                                    } else {
                                        ZStack(alignment: .topLeading) {
                                            
                                            Image("appleLogo")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: (.screenWidth - 40) / 2, height: (.screenWidth - 40) / 2)
                                                .cornerRadius(4)
                                                .clipped()
                                            
                                            Label("03:22:15", systemImage: "timer")
                                                .foregroundColor(.infanMain)
                                                .font(.infanFootnote)
                                                .frame(height: 24)
                                                .padding(4)
//                                                .background(Color.black.opacity(0.1))
//                                                .cornerRadius(4)
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
                                    .padding(.vertical, 10)
                                    
                                }
                                Divider()
                            }
                            .infanHorizontalPadding()
                        }
                    }
                    .padding(.top)
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
            ProductListView(userViewModel: UserViewModel(), auctionViewModel: AuctionProductViewModel())
        }
    }
}
