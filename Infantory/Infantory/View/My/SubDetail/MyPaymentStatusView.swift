//
//  PaymentStatusView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyPaymentStatusView: View {
    var myPaymentStore: MyPaymentStore
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                Text("상품 내역")
                    .font(.infanHeadlineBold)
                    .foregroundColor(.infanBlack)
                Spacer()
            }
            MyPaymentStatusCountView(myPaymentStore: myPaymentStore)
        }
    }
}

struct MyPaymentStatusView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentStatusView(myPaymentStore: MyPaymentStore())
    }
}
