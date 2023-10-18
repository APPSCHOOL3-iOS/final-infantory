//
//  MyPaymentsDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/18.
//

import SwiftUI

struct MyPaymentsDetailView: View {
    var payment: PaymentInfo
    var body: some View {
        switch payment.type {
        case .auction:
            VStack(spacing: 13) {
                HStack {
                    Text("구매가")
                    Spacer()
                    Text("\(payment.auctionProduct?.winningPrice ?? 0)원")
                }
                HStack {
                    Text("수수료")
                    Spacer()
                    Text("0원")
                }
                HStack {
                    Text("배송비")
                    Spacer()
                    Text("\(payment.deliveryCost)원")
                }
                Divider()
                HStack {
                    Text("총 결제금액")
                    Spacer()
                    Text("\((payment.auctionProduct?.winningPrice ?? 0) + (payment.deliveryCost))원")
                }
            }
            .horizontalPadding()

        case .apply:
            VStack(spacing: 13) {
                HStack {
                    Text("구매가")
                    Spacer()
                    Text("\(payment.applyProduct?.winningPrice ?? 0)원")
                }
                HStack {
                    Text("수수료")
                    Spacer()
                    Text("0원")
                }
                HStack {
                    Text("배송비")
                    Spacer()
                    Text("\(payment.deliveryCost)원")
                }
                Divider()
                HStack {
                    Text("총 결제금액")
                    Spacer()
                    Text("\((payment.applyProduct?.winningPrice ?? 0) + (payment.deliveryCost))원")
                }
            }
            .horizontalPadding()

        }
    }
}

struct MyPaymentsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentsDetailView(payment: PaymentInfo(userId: "",
                                                  address: Address.init(address: "",
                                                                        zonecode: "",
                                                                        addressDetail: ""),
                                                  deliveryRequest: .door,
                                                  deliveryCost: 3000,
                                                  paymentMethod: .accountTransfer))
    }
}
