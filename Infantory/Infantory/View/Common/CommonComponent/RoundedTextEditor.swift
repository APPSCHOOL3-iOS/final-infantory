//
//  InfanTextEditor.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/05.
//

import SwiftUI

struct RoundedTextEditor: View {
    
    var textFieldTitle: String? = nil
    var width: CGFloat = .screenWidth - 40
    var height: CGFloat = 140
    var placeHolder: String = ""
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let textFieldTitle {
                Text("\(textFieldTitle)")
                    .font(.infanHeadlineBold)
            }
            RoundedRectangle(cornerRadius: 10)
                .stroke(isFocused == true ? Color.black : Color.infanGray)
                .overlay {
                    ZStack(alignment: .topLeading) {
                        if text == "" {
                            Text("애장품을 소개해주세요")
                                .padding([.top, .leading], 12)
                                .foregroundColor(.infanLightGray)
                        }
                        
                        TextEditor(text: $text)
                            .font(.infanBody)
                            .focused($isFocused)
                            .padding(6)

                    }
                    
                }
                .frame(width: width, height: height)
        }
    }
}
