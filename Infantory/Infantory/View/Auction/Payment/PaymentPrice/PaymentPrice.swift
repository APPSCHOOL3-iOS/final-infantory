//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/20.
//

import SwiftUI

struct PaymentPrice: View {
    @ObservedObject var viewModel: PaymentViewModel
    
    let viewTitle: String = "최종 주문정보"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(viewTitle)
                .font(.headline)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 22) {
                ForEach(PaymentInfoViewModel.allCases, id: \.rawValue) { item in
                    if item == .totalPrice {
                        // 총 결제금액
                        VStack(alignment: .leading, spacing: 22) {
                            Divider()
                            HStack {
                                Text(PaymentInfoViewModel.totalPrice.title)
                                    .padding(.horizontal)
                            }
                            HStack {
                                Spacer()
                                Text("\(item.receipt(productPrice: viewModel.product.winningPrice))원")
                                    .foregroundColor(.red)
                                    .font(.headline)
                                    .padding(.horizontal)
                            }
                            Divider()
                        }
                        .background(Color.gray.opacity(0.1))
                    } else {
                        //가격 구성 정보
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
                            
                            Text("\(item.receipt(productPrice: viewModel.product.winningPrice))원")
                        }
                        .padding(.horizontal)
                    }
                    
                }
            }
            
        }
    }
}

struct PaymentInfo_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPrice(viewModel: PaymentViewModel())
    }
}
