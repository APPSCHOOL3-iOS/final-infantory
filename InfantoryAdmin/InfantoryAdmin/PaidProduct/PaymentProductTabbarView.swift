//
//  PaymentProductTabbarView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/22/23.
//

import SwiftUI

struct PaymentProductTabbarView: View {
    @ObservedObject var payProductStore: PayProductStore
    @Binding var closeCategory: ProductPaidFilter
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(ProductPaidFilter.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            payProductStore.seletedCategory = category
                            closeCategory = category
                        } label: {
                            Text("\(category.rawValue)")
                                .frame(width: UIScreen.main.bounds.width / 4)
                        }
                        .font(.headline)
                        .fontWeight(payProductStore.seletedCategory == category ? .bold : .thin)
                        .foregroundColor(.primary)
                        
                        if payProductStore.seletedCategory == category {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 2)
                            
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
