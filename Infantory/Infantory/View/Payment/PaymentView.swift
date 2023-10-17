//
//  PaymentView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/20.
//

import SwiftUI

struct PaymentView: View {
    var paymentStore: PaymentStore
    @State var paymentInfo: PaymentInfo
    @Binding var isShowingPaymentSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(pinnedViews: .sectionFooters) {
                        PaymentAddressView(paymentStore: paymentStore, paymentInfo: $paymentInfo)
                        
                        PaymentPriceView(price: paymentStore.product.winningPrice ?? 0)
                        
                        PaymentMethodView(paymentStore: paymentStore, paymentInfo: $paymentInfo)
                            .padding(.top)
                        
                        payButton
                    }
                }
            }
            .navigationBar(title: "배송 / 결재")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentView(paymentStore: PaymentStore(user: User.dummyUser, product: AuctionProduct.dummyProduct),
                        paymentInfo: PaymentInfo(userId: "",
                                                 address: Address.init(address: "",
                                                                       zonecode: "",
                                                                       addressDetail: ""),
                                                 deliveryRequest: .door,
                                                 deliveryCost: 3000,
                                                 paymentMethod: .accountTransfer),
                        isShowingPaymentSheet: .constant(true)
            )
        }
    }
}

extension PaymentView {
    
    var payButton: some View {
        NavigationLink {
            PaymentReceiptView(paymentStore: paymentStore,
                               paymentInfo: paymentInfo,
                               isShowingPaymentSheet: $isShowingPaymentSheet)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.infanMain)
                    .frame(height: 54)
                
                Text("결제하기")
                    .foregroundColor(.white)
                    .font(.infanHeadlineBold)
            }
        }
        .padding()
    }
}
