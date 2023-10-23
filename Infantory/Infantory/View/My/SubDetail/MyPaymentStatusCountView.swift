//
//  MyPaymentStatusCountView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyPaymentStatusCountView: View {
    @ObservedObject var myPaymentStore: MyPaymentStore
    @ObservedObject var loginStore: LoginStore
    var body: some View {
            HStack {
                MyPaymentStatusItemView(title: "결제완료", count: myPaymentStore.myPayments.count )
                MyPaymentStatusItemView(title: "준비중", count: 0)
                MyPaymentStatusItemView(title: "배송중", count: 0)
                MyPaymentStatusItemView(title: "배송완료", count: 0)
            }
            .foregroundColor(.infanBlack)
            .onAppear {
                Task {
                   try await myPaymentStore.fetchMyPayments(userId: loginStore.userUid)
                }
            }
    }
}

struct MyPaymentStatusCountView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentStatusCountView(myPaymentStore: MyPaymentStore(), loginStore: LoginStore())
    }
}
