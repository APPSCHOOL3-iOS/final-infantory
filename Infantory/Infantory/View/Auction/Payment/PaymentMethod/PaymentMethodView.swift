//
//  PaymentMethodView.swift
//  Infantory
//
//  Created by 전민돌 on 9/20/23.
//

import SwiftUI

struct PaymentMethodView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("결제 방법")
                .bold()
                .padding(.bottom, 7)
            
            Text("계좌 간편결제")
                .font(.callout)
            
            Button {
                print("계좌 등록 View or Sheet")
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 351, height: 60)
                        .background(.white)
                    
                    Text("계좌를 등록하세요")
                        .bold()
                        .font(.callout)
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 23)
            
            HStack {
                Text("카드 간편결제")
                    .font(.callout)
                
                Text("일시불")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Button {
                print("카드 간편결제 Sheet")
            } label: {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 351, height: 60)
                        .background(.white)
                    
                    HStack {
                        VStack(alignment: .leading) { // 더미 데이터
                            Text("토스뱅크카드")
                            Text("••••-••••-••••-5285")
                        }
                        
                        Image(systemName: "chevron.forward")
                            .padding(.leading, 150)
                    }
                    .font(.callout)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 23)
            
            HStack {
                Text("일반 결제")
                    .font(.callout)
                
                Text("일시불 • 할부")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack {
                PayButtonView(payName: "NaverPay")
                PayButtonView(payName: "KakaoPay")
                    .padding(.leading, 5)
                PayButtonView(payName: "TossPay")
                    .padding(.leading, 5)
            }
        }
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodView()
    }
}
