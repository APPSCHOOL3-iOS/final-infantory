//
//  SearchRectangleView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/13/23.
//

import SwiftUI

struct SearchRectangleView: View {
    var body: some View {
        Rectangle().fill(Color.infanLightGray.opacity(0.3)).frame(height: 5)
            .overlay {
                Divider().offset(y: 2.5)
                Divider().offset(y: -2.5)
        }
    }
}
