//
//  PaymentDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/17.
//

import SwiftUI

struct MyPaymentsListView: View {
    @State private var showingModal: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
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
                    Text("167,000원")
                    Button {
                        showingModal.toggle()
                    } label: {
                        Image(systemName: showingModal ? "chevron.down" : "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 10, height: 13)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                Divider()
                if showingModal {
                    MyPaymentsDetailView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .background(Color.white)
                }
            }
            .padding(.vertical)
            .horizontalPadding()
        }
    }
}

struct MyPaymentsListView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentsListView()
    }
}
