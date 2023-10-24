//
//  MyPaymentStatusItemView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyPaymentStatusItemView: View {
    var title: String
    var count: Int

    var body: some View {
        VStack(spacing: 8) {
            Text("\(count)")
                .foregroundColor(.infanBlack)
                .font(.infanHeadlineBold)
            Text(title)
                .font(.infanFootnote)
        }
        .frame(width: (.screenWidth - 70) / 4)
    }
}
