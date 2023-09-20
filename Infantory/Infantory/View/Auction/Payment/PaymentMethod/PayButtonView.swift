//
//  PayButtonView.swift
//  Infantory
//
//  Created by 전민돌 on 9/20/23.
//

import SwiftUI

struct PayButtonView: View {
    var payName: String
    
    var body: some View {
        Button {
            print("\(payName) 버튼")
        } label: {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 109, height: 50)
                    .background(.white)
                
                Image(payName)
                    .resizable()
                    .frame(width: 70, height: 25)
                    .padding(.leading, 20)
            }
        }
    }
}

struct PayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PayButtonView(payName: "NaverPay")
    }
}
