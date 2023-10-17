//
//  PaymentDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/17.
//

import SwiftUI

struct PaymentDetailsView: View {
    @State private var showingModal: Bool = true
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (.screenWidth - 330), height: 20)
            VStack(spacing: 10) {
                Text("인플루언서 이름")
                Text("상품 이름")
            }
            Spacer()
                Text("10000원")
            Button {
                showingModal.toggle()
            } label: {
                Image(systemName: showingModal ? "chevron.up" : "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 10, height: 13)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .horizontalPadding()
    }
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetailsView()
    }
}
