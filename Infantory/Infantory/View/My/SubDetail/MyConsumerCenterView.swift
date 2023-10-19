//
//  MyConsumerCenterView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyConsumerCenterView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.infanLightGray.opacity(0.3))
                    .frame(width: .screenWidth, height: 230)
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("고객센터 1599-2892")
                            .font(.infanHeadlineBold)
                            .padding(.bottom, 8)
                        Text("운영시간 평일 09:00 ~ 18:00(토,일,공휴일 휴무)")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray.opacity(0.5))
                        Text("점심시간 평일 12:00 ~ 13:00")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray.opacity(0.5))
                        Text("상호명: (주) Infantory")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray.opacity(0.5))
                        Text("메일: 0000@infantory")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray.opacity(0.5))
                        Text("전화번호: 010-0000-0000")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray.opacity(0.5))
                        Text("주소: 서울특별시 종로구 종로3길 17")
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray.opacity(0.5))
                    }
                    Spacer()
                }
                .horizontalPadding()
            }
            Spacer()
        }
    }
}

#Preview {
    MyConsumerCenterView()
}
