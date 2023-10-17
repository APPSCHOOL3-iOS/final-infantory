//
//  MyBidMainView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/17.
//

import SwiftUI

struct MyBidMainView: View {
    var body: some View {
            Form {
                HStack(spacing:10) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (.screenWidth - 120) / 4, height: 40)
                        .padding(.trailing)
                    VStack(spacing: 10) {
                        Text("인플루언서 이름")
                        Text("상품이름")
                    }
                    Spacer()
                    Text("10000원")
                }
            }
            .horizontalPadding()
    }
}

struct MyBidMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyBidMainView()
    }
}
