//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/20.
//

import SwiftUI

struct PaymentPriceView: View {
    let price: Int
    let viewTitle: String = "최종 주문정보"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(viewTitle)
                .font(.headline)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 22) {
                
                ForEach(PaymentCost.allCases, id: \.rawValue) { item in
                    if item == .totalPrice {
                        TotalPriceRow(item: item, price: price)
                    } else {
                        PriceDetailRow(item: item, price: price)
                    }
                    
                }
            }
            
        }
    }
}

struct PaymentPriceView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPriceView(price: 100000)
    }
}

struct TotalPriceRow: View {
    let item: PaymentCost
    let price: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Divider()
            HStack {
                Text(PaymentCost.totalPrice.title)
                    .padding(.horizontal)
            }
            HStack {
                Spacer()
                Text("\(item.receipt(productPrice: price))원")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding(.horizontal)
            }
            Divider()
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct PriceDetailRow: View {
    let item: PaymentCost
    let price: Int
    
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
            
            Text("\(item.receipt(productPrice: price))원")
        }
        .padding(.horizontal)
    }
}
