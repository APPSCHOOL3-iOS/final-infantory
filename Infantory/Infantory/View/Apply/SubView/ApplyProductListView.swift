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
        VStack {
            if applyViewModel.filteredProduct.isEmpty {
                applyEmptyListItemCell
            } else {
                ScrollView {
                    ForEach(applyViewModel.filteredProduct) { product in
                        HStack {
                            ApplyInfluencerImageView(applyViewModel: applyViewModel, product: product)
                            
                            Spacer()
                            
                            ApplyTimerView(applyViewModel: applyViewModel, product: product)
                        }
                        .horizontalPadding()
                        
                        ApplyProductListCellView(applyViewModel: applyViewModel, product: product)
                    }
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
        .task {
            Task {
                do {
                    try await applyViewModel.fetchApplyProducts()
                } catch {
                    
                }
            }
        }
    }
}

extension ApplyProductListView {
    var applyEmptyListItemCell: some View {
        VStack {
            Spacer()
            if applyViewModel.selectedFilter == .inProgress {
                Text("진행중인 응모가 없습니다.")
            } else if applyViewModel.selectedFilter == .planned {
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
            ApplyProductListView(applyViewModel: ApplyProductStore())
        }
    }
}
