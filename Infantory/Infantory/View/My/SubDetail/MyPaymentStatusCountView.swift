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
                MyPaymentStatusItemView(title: "결제완료", count: loginStore.currentUser.applyActivityInfos?.count ?? 0)
                MyPaymentStatusItemView(title: "준비중", count: 0)
                MyPaymentStatusItemView(title: "배송중", count: 0)
                MyPaymentStatusItemView(title: "배송완료", count: 0)
            }
            .foregroundColor(.infanBlack)
            .onAppear {
                Task {
                    print("이게 진짜 임 \(loginStore.currentUser.applyActivityInfos?.count ?? 0)")
                }
            }
    }
}

struct MyPaymentStatusCountView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentStatusCountView(myPaymentStore: MyPaymentStore(), loginStore: LoginStore())
    }
}
