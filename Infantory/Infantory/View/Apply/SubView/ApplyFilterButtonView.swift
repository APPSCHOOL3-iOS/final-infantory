//
//  ApplyFilterButtonView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/06.
//

import SwiftUI

struct ApplyFilterButtonView: View {

    @ObservedObject var applyViewModel: ApplyProductStore
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ApplyFilter.allCases, id: \.rawValue) { filter in
                    Button {
                        applyViewModel.updateFilter(filter: filter)
                    } label: {
                        if applyViewModel.selectedFilter == filter {
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
            if applyViewModel.selectedFilter == .inProgress {
                HStack {
                    ForEach(ApplyInprogressFilter.allCases, id: \.rawValue) { filter in
                        Button {
                            applyViewModel.progressSelectedFilter = filter
                        } label: {
                            if applyViewModel.progressSelectedFilter == filter {
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
        ApplyFilterButtonView(applyViewModel: ApplyProductStore())
    }
}
