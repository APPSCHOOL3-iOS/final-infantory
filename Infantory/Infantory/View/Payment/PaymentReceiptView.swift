//
//  orderReceiptView.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import SwiftUI

struct PaymentReceiptView: View {
    @ObservedObject var viewModel: PaymentViewModel
    
    var body: some View {
        VStack {
            Text("주문이 완료되었습니다!")
                .font(.headline)
                .frame(width: CGFloat.screenWidth - 10, height: 50, alignment: .leading)
                .background(.gray.opacity(0.2))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("주문자")
                            .frame(width: 50, alignment: .leading)
                        Text(viewModel.user.name)
                    }
                    
                    HStack {
                        Text("주소")
                            .frame(width: 50, alignment: .leading)
                        Text(viewModel.user.address.address)
                    }
                }
                .padding()
                
                PaymentPriceView(price: viewModel.product.winningPrice)
            }
            Spacer()
            
            NavigationLink {
                HomeMainView()
                    .navigationBarHidden(true)
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: CGFloat.screenWidth - 30, height: 60)
                    .overlay(
                        Text("완료")
                            .foregroundColor(.white)
                    )
                    .padding()
                
            }
        }
        .infanNavigationBar(title: "구매완료")
        .onAppear {
            viewModel.uploadPaymentInfo()
        }
    }
}

struct ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentReceiptView(viewModel: PaymentViewModel(user: User.dummyUser, product: auctionProduct))
        }
    }
}
