//
//  ApplyFilterButtonView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/06.
//

import SwiftUI

struct ApplyFilterButtonView: View {

    var applyViewModel: ApplyProductStore
    
    var body: some View {
        HStack {
            ForEach(ApplyFilter.allCases, id: \.rawValue) { filter in
                Button {
                    applyViewModel.selectedFilter = filter
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
        .horizontalPadding()
    }
}

struct ApplyFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyFilterButtonView(applyViewModel: ApplyProductStore())
    }
}
