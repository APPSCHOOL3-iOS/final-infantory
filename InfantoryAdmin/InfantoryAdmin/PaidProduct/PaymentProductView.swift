//
//  PaymentProductView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/22/23.
//

import SwiftUI

struct PaymentProductView: View {
    @StateObject var payProductStore: PayProductStore = PayProductStore()
    @State private var closeCategory: ProductPaidFilter = .auction
    var body: some View {
        
        VStack {
            PaymentProductTabbarView(payProductStore: payProductStore, closeCategory: $closeCategory)
            TabView(selection: $closeCategory) {
                ForEach(ProductPaidFilter.allCases, id: \.self) { category in
                    switch closeCategory {
                    case .auction:
                        ScrollView {
                            VStack {
                                ForEach (payProductStore.auctionProducts) { product in
                                    if product.isPaid == false {
                                        HStack {
                                            AsyncImage(url: URL(string: product.productImageURLStrings[0])) { image in
                                                ZStack {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                    
                                                    Text("결제예정")
                                                        .padding(10)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .background(Color.gray)
                                                        .cornerRadius(20)
                                                }
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            VStack {
                                                Text("\(product.productName)")
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    } else {
                                        HStack {
                                            AsyncImage(url: URL(string: product.productImageURLStrings[0])) { image in
                                                ZStack {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                    
                                                    Text("결제완료")
                                                        .padding(10)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .background(Color.orange)
                                                        .cornerRadius(20)
                                                }
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            VStack {
                                                Text("\(product.productName)")
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }.tag(category)
                    case .apply:
                        ScrollView {
                            VStack {
                                ForEach (payProductStore.applyProducts) { product in
                                    if product.isPaid == true {
                                        HStack {
                                            AsyncImage(url: URL(string: product.productImageURLStrings[0])) { image in
                                                ZStack {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                    
                                                    Text("결제완료")
                                                        .padding(10)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .background(Color.orange)
                                                        .cornerRadius(20)
                                                }
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            VStack {
                                                Text("\(product.productName)")
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    } else {
                                        HStack {
                                            AsyncImage(url: URL(string: product.productImageURLStrings[0])) { image in
                                                ZStack {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 100) / 2)
                                                        .clipped()
                                                        .cornerRadius(10)
                                                    
                                                    Text("결제예정")
                                                        .padding(10)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .background(Color.gray)
                                                        .cornerRadius(20)
                                                }
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            VStack {
                                                Text("\(product.productName)")
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }.tag(category)
                        
                    }
                }
            }
            .padding()
        }
        .refreshable {
            try? await payProductStore.fetchProduct()
        }
        .task {
            try? await payProductStore.fetchProduct()
            
        }
        
    }
}

struct PaymentProductView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentProductView()
    }
}

