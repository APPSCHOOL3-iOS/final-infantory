//
//  ApplyFilterButtonView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/06.
//

import SwiftUI

struct ApplyFilterButtonView: View {
    
    @State private var selectedFilter = ApplyFilter.inProgress
    
    var body: some View {
        HStack {
            ForEach(ApplyFilter.allCases, id: \.rawValue) { filter in
                Button {
                    selectedFilter = filter
                } label: {
                    if selectedFilter == filter {
                        Text(filter.rawValue)
                            .padding(10)
                            .font(.infanFootnoteBold)
                            .foregroundColor(.white)
                            .background(Color.infanDarkGray)
                            .cornerRadius(20)
                    } else {
                        Text(filter.rawValue)
                            .padding(10)
                            .font(.infanFootnote)
                            .foregroundColor(.infanDarkGray)
                            .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.infanLightGray, lineWidth: 1)
                            )
                    }
                }
            }
            Spacer()
        }
        .infanHorizontalPadding()
    }
}

struct ApplyFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyFilterButtonView()
    }
}
