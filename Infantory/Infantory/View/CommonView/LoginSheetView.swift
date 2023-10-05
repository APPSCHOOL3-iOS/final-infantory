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
                    
                    Spacer().frame(height: 30)
                    Text("로그인 후\n이용해주세요.")
                        .font(.infanTitle2Bold)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 30)
                    Group {
                        Button {
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
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 54)
                                    .foregroundColor(.yellow)
                                
                                HStack(alignment: .center) {
                                    Image("kakaoLogo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35)
                                    Text("카카오로 계속하기")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .padding(.leading, -5)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            // login 기능 구현
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 54)
                                    .foregroundColor(.black)
                                
                                HStack(alignment: .center) {
                                    Image("appleLogo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 27)
                                        .clipShape(Circle())
                                    Text("Apple로 계속하기")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.leading, -5)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .infanHorizontalPadding()
            }
            .fullScreenCover(isPresented: $isShowingSignUp) {
                LoginSignUpView()
            }
        }
        .presentationDetents([.height(CGFloat.screenHeight * 0.7)])
    }
}

struct LoginSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSheetView()
            .environmentObject(LoginStore())
    }
}
