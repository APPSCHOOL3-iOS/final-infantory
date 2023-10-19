//
//  MyPaymentStatusCountView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyPaymentStatusCountView: View {
    @ObservedObject var myPaymentStore: MyPaymentStore
    var body: some View {
        ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.infanLightGray.opacity(0.3))

                    HStack {
                        MyPaymentStatusItemView(title: "결제완료", count: myPaymentStore.myPayments.count)
                        MyPaymentStatusItemView(title: "준비중", count: 0)
                        MyPaymentStatusItemView(title: "배송중", count: 0)
                        MyPaymentStatusItemView(title: "배송완료", count: 0)
                    }
                    .padding(.vertical, 16)
                    .foregroundColor(.infanBlack)
                }
    }
}

struct MyPaymentStatusCountView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentStatusCountView(myPaymentStore: MyPaymentStore())
    }
}
