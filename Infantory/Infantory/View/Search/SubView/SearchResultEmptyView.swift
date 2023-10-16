//
//  SearchResultEmptyView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/13/23.
//

import SwiftUI

struct SearchResultEmptyView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: .screenHeight * 0.04)
            Text("검색된 결과가 없습니다.")
            Spacer()
        }
    }
}
