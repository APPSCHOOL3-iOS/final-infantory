//
//  PaymentStatusView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyPaymentStatusView: View {
    @ObservedObject var myPaymentStore: MyPaymentStore
    @ObservedObject var loginStore: LoginStore
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                Text("상품 내역")
                    .font(.infanHeadlineBold)
                    .foregroundColor(.infanBlack)
                Spacer()
            }
            MyPaymentStatusCountView(myPaymentStore: myPaymentStore, loginStore: loginStore)
        }
    }
}

struct MyPaymentStatusView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentStatusView(myPaymentStore: MyPaymentStore(), loginStore: LoginStore())
    }
}
