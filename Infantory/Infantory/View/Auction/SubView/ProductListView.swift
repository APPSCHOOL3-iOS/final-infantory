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
                    ZStack {
                        NavigationLink(destination: AuctionDetailView(userViewModel: userViewModel, auctionProductViewModel: auctionViewModel)) {
                            EmptyView()
                        }
                        .buttonStyle(.plain)
                        
                        VStack {
                            // 배열의 첫번째 값 넣어둠.
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                
                                Text("\(userViewModel.user.name)")
                                    .font(.infanHeadline)
                                
                                Spacer()
                                Button(action: {
                                    heartButton.toggle()
                                }, label: {
                                    Image(systemName: heartButton ? "heart.fill" : "heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                        .foregroundColor(.infanDarkGray)
                                })
                            }
                            .infanHorizontalPadding()
                         
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    if product.productImageURLStrings.count > 0 {
                                        Image("\(product.productImageURLStrings[0])")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150, height: 160)
                                    } else {
                                        Image("appleLogo")
                                            .resizable()
                                            .frame(width: 150, height: 160)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Text("Hot")
                                                .font(.infanFootnote)
                                                .frame(width: 40, height: 20)
                                                .foregroundColor(.infanDarkGray)
                                                .background(Color.infanRed)
                                                .cornerRadius(10)
                                            Text("New")
                                                .font(.infanFootnote)
                                                .frame(width: 40, height: 20)
                                                .foregroundColor(.infanDarkGray)
                                                .background(Color.infanGreen)
                                                .cornerRadius(10)
                                        }
                                        VStack(alignment: .leading) {
                                            Text("상품명: \(product.productName)")
                                                .font(.infanTitle2)
                                                .foregroundColor(.infanDarkGray)
                                            Text("남은시간: 03:02:01")
                                                .font(.infanBody)
                                                .foregroundColor(.infanDarkGray)
                                            Text("현재 입찰가: \(product.winningPrice ?? 0)")
                                                .font(.infanBody)
                                                .foregroundColor(.infanDarkGray)
                                        }
                                    }
                                }
                                .infanHorizontalPadding()
                                
                            }
                            Rectangle()
                                .fill(Color.infanLightGray)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding(.vertical)
            .onAppear {
                Task {
                    do {
                        try await auctionViewModel.fetchAuctionProducts()
                    }
                    catch {
                        
                    }
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
