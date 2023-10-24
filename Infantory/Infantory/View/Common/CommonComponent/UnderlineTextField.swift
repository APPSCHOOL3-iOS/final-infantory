//
//  InfanTextField.swift
//  Infantory
//
//

import SwiftUI

struct UnderlineTextField: View {
    var textFieldTitle: String? = nil
    let placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let textFieldTitle {
                Text("\(textFieldTitle)")
                    .font(.infanHeadlineBold)
            }
            
            TextField(placeholder, text: $text)
                .font(.infanBody)
                .foregroundColor(.black)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.bottom, 4)
            
            Rectangle()
                .foregroundColor(isFocused ? Color.black : Color.infanGray)
                .frame(height: 1)
        }
    }
}
