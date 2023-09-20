//
//  TextField+Basic.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import Foundation
import SwiftUI

struct BasicTextField: ViewModifier {
    func body(content: Content) -> some View {
            content
            .padding(10)
        }
}


extension View {
    func asBasicTextField() -> some View {
        modifier(BasicTextField())
    }
}
