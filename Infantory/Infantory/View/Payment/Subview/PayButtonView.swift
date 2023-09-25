//
//  PayButtonView.swift
//  Infantory
//
//  Created by 전민돌 on 9/20/23.
//

import SwiftUI

struct PayButtonView: View {
    @ObservedObject var viewModel: PaymentViewModel
    var payName: PaymentMethod
    
    var body: some View {
        var isSelectedMethod =  viewModel.paymentInfo.paymentMethod == payName
        
        return (
            Button {
                viewModel.paymentInfo.paymentMethod = payName
            } label: {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            isSelectedMethod ? .black : .gray,
                            lineWidth: isSelectedMethod ? 2 : 1
                        )
                        .frame(width: 109, height: 50)
                        .background(.white)
                    
                    Image(payName.rawValue)
                        .resizable()
                        .frame(width: 70, height: 25)
                        .padding(.leading, 20)
                }
            }
        )
    }
}

struct PayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PayButtonView(
            viewModel: PaymentViewModel(user: User.dummyUser, product: auctionProduct),
            payName: PaymentMethod.naverPay
        )
    }
}
