//
//  SearchTotalCellView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/13/23.
//

import SwiftUI
    
struct SearchTotalCellView<Content: View>: View {
    var category: String
    var content: Content
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(category)").font(.infanBody.bold()).foregroundColor(.infanMain.opacity(0.7)).padding()
            content
        }
    }
}
