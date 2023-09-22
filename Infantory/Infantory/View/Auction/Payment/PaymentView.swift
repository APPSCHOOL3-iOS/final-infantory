//
//  PaymentView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/20.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(pinnedViews: .sectionFooters) {
                    Section {
                        PaymentAddressView()
                        
                        PaymentPrice()
                        
                        PaymentMethodView()
                            .padding(.top)
                        
                        payButton
                    }
                }
                
            }
        }
        .navigationTitle("배송 / 결제")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentView()
        }
    }
}

extension PaymentView {
    
    var payButton: some View {
        Button {
            payAction()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 50)
                    .background(.white)
                Text("결제하기")
                    .foregroundColor(.black)
                    .font(.headline)
            }
        }
        .padding()
    }
    
    func payAction() {
        
    }
}
