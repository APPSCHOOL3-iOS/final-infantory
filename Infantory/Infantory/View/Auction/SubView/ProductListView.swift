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
        List {
            ForEach(auctionViewModel.auctionProduct) { product in
                NavigationLink {
                    AuctionDetailView(userViewModel: userViewModel, auctionProductViewModel: auctionViewModel)
                } label: {
                    VStack {
                        // 배열의 첫번째 값 넣어둠.
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35)
                            Text("\(userViewModel.user.name)")
                            Spacer()
                            Button(action: {
                                heartButton.toggle()
                            }, label: {
                                Image(systemName: heartButton ? "heart.fill" : "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .foregroundColor(.infanDarkGray)
                            })
                        }
                        .padding([.horizontal, .top])
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                if product.productImageURLStrings.count > 0 {
                                    Image("\(product.productImageURLStrings[0])")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 160)
                                } else {
                                    EmptyView()
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
                                    VStack(alignment: .leading){
                                        Text("상품명: \(product.productName)")
                                            .font(.infanTitle2)
                                            .foregroundColor(.infanDarkGray)
                                            .padding(.bottom)
                                        Text("남은시간: 03:02:01")
                                            .font(.infanBody)
                                            .foregroundColor(.infanDarkGray)
                                        Text("현재 입찰가: \(product.winningPrice ?? 0)")
                                            .font(.infanBody)
                                            .foregroundColor(.infanDarkGray)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
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
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(userViewModel: UserViewModel(), auctionViewModel: AuctionProductViewModel())
    }
}
