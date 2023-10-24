//
//  ReportTabBarView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import SwiftUI

struct ReportTabBarView: View {
    @ObservedObject var reportStore: ReportStore
    @Binding var reportProductType: ReportProductType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(ReportProductType.allCases, id: \.self) { category in
                    VStack {
                        Button {
                            reportStore.selectedCatogory = category
                            reportProductType = category
                        } label: {
                            Text("\(category.rawValue)")
                                .frame(width: UIScreen.main.bounds.width / 4)
                        }
                        .font(.headline)
                        .fontWeight(reportStore.selectedCatogory == category ? .bold : .thin)
                        .foregroundColor(.primary)
                        
                        if reportStore.selectedCatogory == category {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 2)
                            
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
