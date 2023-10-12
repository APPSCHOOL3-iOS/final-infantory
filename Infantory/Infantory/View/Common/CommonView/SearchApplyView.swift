//
//  SearchApplyView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/12/23.
//

import SwiftUI

struct SearchApplyView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    
    var body: some View {
        ForEach(applyViewModel.applyProduct) { product in
            ApplyProductListCellView(applyViewModel: applyViewModel, product: product)
        }
    }
}

struct SearchApplyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchApplyView(applyViewModel: ApplyProductStore())
    }
}
