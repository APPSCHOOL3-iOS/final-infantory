//
//  InfanNavigationBar.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/22.
//

import SwiftUI

struct InfanNavigationBar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let title: String
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
    }
}
