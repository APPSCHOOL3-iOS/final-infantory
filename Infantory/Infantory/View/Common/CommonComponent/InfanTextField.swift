//
//  InfanTextField.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/05.
//

import SwiftUI

struct InfanTextField: View {
    
    var textFieldTitle: String? = nil
    let title: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let textFieldTitle {
                Text("\(textFieldTitle)")
                    .font(.infanHeadlineBold)
            }
            
            TextField(title, text: $text)
            //            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                .font(.infanBody)
                .foregroundColor(.black)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.bottom, 4)
        
            
            Rectangle()
                .foregroundColor(isFocused ? Color.infanMain : Color.infanGray)
                .frame(height: 1)
     
        }
       
//        .onChange(of: text, perform: { newValue in
//            if newValue.count > maxLength {
//                text = String(newValue.prefix(maxLength))
//                isFocused = false
//            }
//        })
    }
}
