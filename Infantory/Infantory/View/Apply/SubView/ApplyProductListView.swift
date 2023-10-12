//
//  ApplyProductListView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/27.
//

import SwiftUI

struct ApplyProductListView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach($applyViewModel.filteredProduct) { $product in
                    ApplyProductListCellView(applyViewModel: applyViewModel, product: $product)
                }
            }
        }
        .refreshable {
            Task {
                do {
                    try await applyViewModel.fetchApplyProducts()
                } catch {
                    
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await applyViewModel.fetchApplyProducts()
                } catch {
                    
                }
            }
        }
    }
}

struct ApplyProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplyProductListView(applyViewModel: ApplyProductStore())
        }
    }
}
