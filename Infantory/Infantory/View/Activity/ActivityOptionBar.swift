//
//  ActivityOptionBar.swift
//  Infantory
//
//  Created by 변상필 on 10/11/23.
//

import SwiftUI

struct ActivityOptionBar: View {
    @Binding var selectedFilter: ActivityOption
    
    @Namespace var animation
    
    var body: some View {
        HStack {
            ForEach(ActivityOption.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.infanBody)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .infanBlack : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(.infanMain)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedFilter = item
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
}

struct ActivityOptionBar_Previews: PreviewProvider {
    static var previews: some View {
        ActivityOptionBar(selectedFilter: .constant(ActivityOption.auction))
    }
}
