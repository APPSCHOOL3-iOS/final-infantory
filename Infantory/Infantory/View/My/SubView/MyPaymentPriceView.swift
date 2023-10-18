//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/20.
//

import SwiftUI

struct MyPaymentPriceView: View {
    let price: Int
    let viewTitle: String = "최종 주문정보"
    var payment: PaymentInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(viewTitle)
                .font(.headline)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 22) {
                
                ForEach(PaymentCost.allCases, id: \.rawValue) { item in
                    if item == .totalPrice {
                        TotalPriceRow(item: item, price: payment.auctionProduct?.winningPrice ?? 0)
                    } else {
                        PriceDetailRow(item: item, price: payment.auctionProduct?.winningPrice ?? 0)
                    }
                    
                }
            }
            
        }
    }
}

struct MyPaymentPriceView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentPriceView(price: 100000, payment: PaymentInfo(userId: "",
                                                               address: Address.init(address: "",
                                                                                     zonecode: "",
                                                                                     addressDetail: ""),
                                                               deliveryRequest: .door,
                                                               deliveryCost: 3000,
                                                               paymentMethod: .accountTransfer))
    }
}

struct MyTotalPriceRow: View {
    let item: PaymentCost
    let price: Int
    var payment: PaymentInfo
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Divider()
            HStack {
                Text(PaymentCost.totalPrice.title)
                    .padding(.horizontal)
            }
            HStack {
                Spacer()
                Text("\(item.receipt(productPrice: payment.auctionProduct?.winningPrice ?? 0))원")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding(.horizontal)
            }
            Divider()
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct MyPriceDetailRow: View {
    let item: PaymentCost
    let price: Int
    var payment: PaymentInfo
    var body: some View {
        HStack {
            Text(item.title)
                .foregroundColor(.gray)
            if item == .commission {
                Button {
                    //수수료 안내 액션
                } label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            
            Text("\(item.receipt(productPrice: payment.auctionProduct?.winningPrice ?? 0))원")
        }
        .padding(.horizontal)
    }
}
