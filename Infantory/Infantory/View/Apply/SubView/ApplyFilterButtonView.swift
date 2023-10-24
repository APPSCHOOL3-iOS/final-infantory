//
//  ApplyFilterButtonView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/06.
//

import SwiftUI

struct ApplyFilterButtonView: View {

    @ObservedObject var applyProductStore: ApplyProductStore
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ApplyFilter.allCases, id: \.rawValue) { filter in
                    Button {
                        applyProductStore.updateFilter(filter: filter)
                    } label: {
                        if applyProductStore.selectedFilter == filter {
                            Text(filter.rawValue)
                                .padding(10)
                                .font(.infanFootnoteBold)
                                .foregroundColor(.white)
                                .background(Color.infanDarkGray)
                                .cornerRadius(10)
                        } else {
                            Text(filter.rawValue)
                                .padding(10)
                                .font(.infanFootnote)
                                .foregroundColor(.infanDarkGray)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.infanLightGray, lineWidth: 1)
                                )
                        }
                    }
                }
                Spacer()
            }
            if applyProductStore.selectedFilter == .inProgress {
                HStack {
                    ForEach(ApplyInprogressFilter.allCases, id: \.rawValue) { filter in
                        Button {
                            applyProductStore.progressSelectedFilter = filter
                            applyProductStore.sortInProgressProduct(filter: filter)
                        } label: {
                            if applyProductStore.progressSelectedFilter == filter {
                                Text(filter.rawValue)
                                    .padding(10)
                                    .font(.infanFootnoteBold)
                                    .foregroundColor(.infanMain)
                                    
                            } else {
                                Text(filter.rawValue)
                                    .padding(10)
                                    .font(.infanFootnote)
                                    .foregroundColor(.infanDarkGray)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .horizontalPadding()
    }
}

struct ApplyFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyFilterButtonView(applyProductStore: ApplyProductStore())
    }
}
