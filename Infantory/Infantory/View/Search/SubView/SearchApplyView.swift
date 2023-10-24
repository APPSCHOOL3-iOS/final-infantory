//
//  SearchApplyView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/12/23.
//

import SwiftUI

struct SearchApplyView: View {
    
    @ObservedObject var applyProductStore: ApplyProductStore
    @ObservedObject var searchStore: SearchStore
    var showCellCount: SearchResultCount
    
    var body: some View {
        ScrollView {
            VStack {
                if showCellCount == .underLimit {
                    ForEach(applyProductStore.applyProduct) { product in
                        HStack {
                            ApplyInfluencerImageView(applyProductStore: applyProductStore, product: product)
                            Spacer()
                            ApplyTimerView(applyProductStore: applyProductStore, product: product)
                        }
                        .horizontalPadding()
                        
                        ApplyProductListCellView(applyProductStore: applyProductStore, product: product)
                    }
                } else {
                    ForEach(applyProductStore.applyProduct.prefix(3)) { product in
                        HStack {
                            ApplyInfluencerImageView(applyProductStore: applyProductStore, product: product)
                            Spacer()
                            ApplyTimerView(applyProductStore: applyProductStore, product: product)
                        }
                        .horizontalPadding()
                        
                        ApplyProductListCellView(applyProductStore: applyProductStore, product: product)
                    }
                }
            }
        }
        .padding(.bottom, 1)
    }
}

struct SearchApplyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchApplyView(applyProductStore: ApplyProductStore(), searchStore: SearchStore(), showCellCount: .overLimit)
    }
}
