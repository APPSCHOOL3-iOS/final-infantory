//
//  PaymentView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/20.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(pinnedViews: .sectionFooters) {
                    Section {
                        PaymentAddressView()
                    
                        PaymentPrice()

                        PaymentMethodView()
                        
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
