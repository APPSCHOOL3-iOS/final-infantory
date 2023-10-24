//
//  PaymentMethodView.swift
//  Infantory
//
//  Created by 전민돌 on 9/20/23.
//

import SwiftUI

struct PaymentMethodView: View {
    var paymentStore: PaymentStore
    @Binding var paymentInfo: PaymentInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("결제 방법")
                .bold()
                .padding(.bottom, 7)
            
            accountButton //계좌로 간편결제 선택, 계좌등록
            
            cardButton //카드로 간편결제 선택, 카드등록
            
            easyPaymentButton //페이 간편결제 선택
        }
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentMethodView(paymentStore: PaymentStore(user: User.dummyUser,
                                                         product: AuctionProduct.dummyProduct),
                              paymentInfo: .constant(PaymentInfo(userId: "",
                                                                 address: Address.init(address: "",
                                                                                       zonecode: "",
                                                                                       addressDetail: ""),
                                                                 deliveryRequest: .door,
                                                                 deliveryCost: 3000,
                                                                 paymentMethod: .accountTransfer))
            )
        }
    }
}

extension PaymentMethodView {
    var accountButton: some View {
        let isSelectedMethod = paymentInfo.paymentMethod == .accountTransfer
        
        return(
            VStack(alignment: .leading) {
                Text("계좌 간편결제")
                    .font(.callout)
                
                Button {
                    paymentInfo.paymentMethod  = .accountTransfer
                } label: {
                    NavigationLink {
                        PaymentChoiceView()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                isSelectedMethod ? .black : .gray,
                                lineWidth: isSelectedMethod ? 2 : 1
                            )
                            .frame(width: 351, height: 60)
                            .background(.white)
                            .overlay(
                                Text("계좌를 등록하세요")
                                    .bold()
                                    .font(.callout)
                                    .foregroundColor(.black)
                            )
                    }
                }
                .padding(.bottom, 23)
            }
        )
    }
    
    var cardButton: some View {
        let isSelectedMethod =  paymentInfo.paymentMethod == .card
        
        return (
            VStack(alignment: .leading) {
                HStack {
                    Text("카드 간편결제")
                        .font(.callout)
                    
                    Text("일시불")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Button {
                    paymentInfo.paymentMethod = .card
                } label: {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                isSelectedMethod ? .black : .gray,
                                lineWidth: isSelectedMethod ? 2 : 1
                            )
                            .frame(width: 351, height: 60)
                            .background(.white)
                        
                        HStack {
                            VStack(alignment: .leading) { // 더미 데이터
                                Text("삼성카드")
                                Text("••••-••••-••••-1234")
                            }
                            
                            NavigationLink {
                                PaymentCardAddView()
                            } label: {
                                Image(systemName: "chevron.forward")
                                    .padding(.leading, 150)
                            }
                        }
                        .font(.callout)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 23)
            }
        )
    }
    
    var easyPaymentButton: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("일반 결제")
                    .font(.callout)
                
                Text("일시불 • 할부")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack(alignment: .center, spacing: 15) {
                PayButtonView(paymentInfo: $paymentInfo, payName: .naverPay)
                PayButtonView(paymentInfo: $paymentInfo, payName: .kakaoPay)
                PayButtonView(paymentInfo: $paymentInfo, payName: .tossPay)
            }
        }
    }
}
