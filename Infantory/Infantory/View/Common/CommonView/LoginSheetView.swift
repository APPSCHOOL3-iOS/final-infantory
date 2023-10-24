//
//  LoginSheetView.swift
//  Infantory
//
//  Created by 민근의 mac on 2023/09/20.
//

import SwiftUI

struct LoginSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var loginStore: LoginStore
    @State private var isShowingSignUp = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Gradient(colors: [.blue, .purple]))
                    .ignoresSafeArea()
                
                VStack {
                    Text("W E L C O M E")
                        .font(.headline.bold())
                        .foregroundColor(.infanMain)
                    
                    Text("로그인 후\n이용해주세요.")
                        .font(.infanTitle2Bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Group {
                        // 카카오
                        LoginButton(
                            backgroundColor: .yellow,
                            image: "kakaoLogo",
                            text: "카카오로 계속하기",
                            textColor: .black,
                            action: loginWithKakao
                        )
                        
                        // 애플
                        LoginButton(
                            backgroundColor: .black,
                            image: "appleLogo",
                            text: "Apple로 계속하기",
                            textColor: .white
                        ) {
                            // login 기능 구현
                        }
                    }
                }
                .horizontalPadding()
            }
            .fullScreenCover(isPresented: $isShowingSignUp) {
                LoginSignUpView()
            }
        }
        .presentationDetents([.height(CGFloat.screenHeight * 0.7)])
    }
    
    func loginWithKakao() {
        loginStore.kakaoAuthSignIn(completion: { result in
            if result {
                Task {
                    if !loginStore.userUid.isEmpty {
                        try await loginStore.fetchUser(userUID: loginStore.userUid)
                    }
                }
               dismiss()
            } else {
                isShowingSignUp = true
            }
        })
    }
}

struct LoginSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSheetView()
            .environmentObject(LoginStore())
    }
}

struct LoginButton: View {
    var backgroundColor: Color
    var image: String
    var text: String
    var textColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 54)
                    .foregroundColor(backgroundColor)
                
                HStack(alignment: .center) {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: image == "appleLogo" ? 27 : 35)
                    
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(textColor)
                        .fontWeight(.bold)
                        .padding(.leading, -5)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
