//
//  ApplyProductListView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/27.
//

import SwiftUI

struct ApplyProductListView: View {
    
    @ObservedObject var applyProductStore: ApplyProductStore
    @State private var heartButton: Bool = false
    
    var body: some View {
        VStack {
            if applyProductStore.filteredProduct.isEmpty {
                applyEmptyListItemCell
            } else {
                ScrollView {
                    ForEach(applyProductStore.filteredProduct) { product in
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
        .refreshable {
            Task {
                do {
                    try await applyProductStore.fetchApplyProducts()
                } catch {
                    
                }
            }
        }
        .task {
            do {
                try await applyProductStore.fetchApplyProducts()
            } catch {
                
            }
        }
    }
}

extension ApplyProductListView {
    var applyEmptyListItemCell: some View {
        VStack {
            Spacer()
            if applyProductStore.selectedFilter == .inProgress {
                Text("진행중인 응모가 없습니다.")
            } else if applyProductStore.selectedFilter == .planned {
                Text("진행 예정인 응모가 없습니다.")
            } else {
                Text("종료된 응모가 없습니다.")
            }
            Spacer()
        }
        .font(.infanBody)
        .foregroundColor(.infanGray)
    }
}

struct ApplyProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplyProductListView(applyProductStore: ApplyProductStore())
        }
    }
}
