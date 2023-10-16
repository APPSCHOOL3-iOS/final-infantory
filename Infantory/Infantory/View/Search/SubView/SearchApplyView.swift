//
//  SearchApplyView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/12/23.
//

import SwiftUI

struct SearchApplyView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    @ObservedObject var searchStore: SearchStore
    var showCellCount: SearchResultCount
    
    var body: some View {
        ScrollView {
            VStack {
                if showCellCount == .underLimit {
                    ForEach(applyViewModel.applyProduct) { product in
                        ApplyInfluencerImageView(applyViewModel: applyViewModel, product: product)
                        ApplyProductListCellView(applyViewModel: applyViewModel, product: product)
                    }
                } else {
                    ForEach(applyViewModel.applyProduct.prefix(3)) { product in
                        ApplyInfluencerImageView(applyViewModel: applyViewModel, product: product)
                        ApplyProductListCellView(applyViewModel: applyViewModel, product: product)
                    }
                }
            }
        }
        .padding(.bottom, 1)
    }
}

struct SearchApplyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchApplyView(applyViewModel: ApplyProductStore(), searchStore: SearchStore(), showCellCount: .overLimit)
    }
}
