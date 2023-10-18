//
//  MyPaymentsDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/18.
//

import SwiftUI

struct MyPaymentsDetailView: View {
    var body: some View {
        VStack(spacing: 13) {
            HStack {
                Text("구매가")
                Spacer()
                Text("158,000원")
            }
            HStack {
                Text("수수료")
                Spacer()
                Text("4,700원")
            }
            HStack {
                Text("배송비")
                Spacer()
                Text("5,000원")
            }
            Divider()
            HStack {
                Text("총 결제금액")
                Spacer()
                Text("167,000원")
            }
        }
        .horizontalPadding()
    }
}

struct MyPaymentsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentsDetailView()
    }
}
