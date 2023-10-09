//
//  PaymentCardAddView.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/26.
//

import SwiftUI

struct PaymentCardAddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .stroke( .gray.opacity(0.5), lineWidth: 1 )
                .frame(width: CGFloat.screenWidth - 40, height: 50)
                .overlay(
                    Button {
                        
                    } label: {
                        Text("+ 새 카드 추가하기")
                            .foregroundColor(.black.opacity(0.75))
                            .frame(width: CGFloat.screenWidth - 60)
                            .padding()
                    }
                )
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .overlay(
                            Text("삼성")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                        .frame(width: CGFloat.screenWidth / 5, height: CGFloat.screenHeight / 15)
                    VStack(alignment: .leading) {
                        Text("••••-••••-••••-1234")
                            .foregroundColor(.black)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 70, height: 25)
                            .foregroundColor(.gray.opacity(0.15))
                            .overlay(
                                Text("기본결제")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            )
                    }
                }
                .padding(.vertical)
            }
            
            Divider()
            
            Spacer()
        }
        .navigationBar(title: "결제 정보")
        .padding()
        
    }
}

struct PaymentCardAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentCardAddView()
        }
    }
}
