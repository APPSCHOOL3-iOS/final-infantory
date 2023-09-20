//
//  LoginSignUpView.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/20.
//

import SwiftUI

struct LoginSignUpView: View {
    
    @State var isFocused: Bool = false
    @State private var text: String = ""
    @FocusState private var isFocusTextField: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("닉네임")
            TextField("", text: $text)
                .overlay(UnderLineOverlay())
        }
        .padding()
        .navigationTitle("회원가입")
    }
}

struct UnderLineOverlay: View {
    
    var body: some View {
        VStack {
            Divider()
                .offset(x: 0, y: 15)
        }
    }
}

struct LoginSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginSignUpView()
        }
    }
}
