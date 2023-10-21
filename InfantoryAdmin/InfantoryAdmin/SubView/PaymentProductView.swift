//
//  PaymentProductView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

struct PaymentProductView: View {
    @StateObject var payProductStore: PayProductStore = PayProductStore()
    @State private var closeCategory: ProductPaidFilter = .beforePaid
    var body: some View {
        
        VStack {
            PaymentProductTabbarView(payProductStore: payProductStore, closeCategory: $closeCategory)
            TabView(selection: $closeCategory) {
                ForEach(ProductPaidFilter.allCases, id: \.self) { category in
                    switch closeCategory {
                    case .beforePaid:
                        ScrollView {
                            VStack {
                                Text("응모")
                                    .font(.largeTitle)
                                ForEach (payProductStore.applyProducts) { product in
                                    if product.isPaid == false {
                                        
                                        HStack {
                                            Text("\(product.productName)")
                                            Text("\(product.isPaid ? "결제함" : "안함")")
                                        }
                                    }
                                }
                                Text("경매")
                                    .font(.largeTitle)
                                ForEach (payProductStore.auctionProducts) { product in
                                    if product.isPaid == false {
                                        
                                        HStack {
                                            Text("\(product.productName)")
                                            Text("\(product.isPaid ? "결제함" : "안함")")
                                        }
                                    }
                                }
                            }
                        }.tag(category)
                    case .afterPaid:
                        ScrollView {
                            VStack {
                                Text("응모")
                                    .font(.largeTitle)
                                ForEach (payProductStore.applyProducts) { product in
                                    if product.isPaid == true {
                                        
                                        HStack {
                                            Text("\(product.productName)")
                                            Text("\(product.isPaid ? "결제함" : "안함")")
                                        }
                                    }
                                }
                                Text("경매")
                                    .font(.largeTitle)
                                ForEach (payProductStore.auctionProducts) { product in
                                    if product.isPaid == true {
                                        
                                        HStack {
                                            Text("\(product.productName)")
                                            Text("\(product.isPaid ? "결제함" : "안함")")
                                        }
                                    }
                                }
                            }
                        }.tag(category)
                        
                    }
                }
            }
            
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
