//
//  orderReceiptView.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import SwiftUI

struct ReceiptView: View {
    @ObservedObject var viewModel: PaymentViewModel
    
    var body: some View {
        VStack {
            Text("주문이 완료되었습니다!")
                .font(.headline)
                .frame(width: CGFloat.screenWidth - 10, alignment: .leading)
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
                        Text(viewModel.user.address.detailAddress) // 요기바꿈
                    }
                }
                .padding()
                
                PaymentPriceView(price: viewModel.product.winningPrice ?? 0)
            }
            Spacer()
            
            Button {
                // 홈으로~~~
            } label: {
                Text("완료")
            }
        }
        .infanNavigationBar(title: "구매완료")
    }
}

struct ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReceiptView(viewModel: PaymentViewModel(user: User.dummyUser, product: auctionProduct))
        }
    }
}
