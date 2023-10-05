//
//  InfanHorizontalPadding.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/26.
//

import SwiftUI

struct InfanHorizontalPadding: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
    }
    
}
