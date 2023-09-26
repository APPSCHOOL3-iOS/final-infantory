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
    @State private var isShowingProgressView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Gradient(colors: [.blue, .purple]))
                    .ignoresSafeArea()
                VStack {
                    Text("W E L C O M E").font(.headline.bold())
                        .foregroundColor(.indigo)
                    Spacer().frame(height: 30)
                    Text("로그인 후").font(.largeTitle.bold())
                    Text("이용해주세요.").font(.largeTitle.bold())
                    Spacer().frame(height: 30)
                    Group {
                        Button {
                            isShowingProgressView = true
                            startTask()
                            loginStore.kakaoAuthSignIn(completion: { result in
                                if result {
                                    dismiss()
                                } else {
                                    isShowingSignUp = true
                                }
                            })
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 330, height: 50)
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
                                    .frame(width: 330, height: 50)
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
                if isShowingProgressView {
                                ProgressView("Loading...")
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .onDisappear {
                                        // 프로그레스 뷰가 사라질 때 작업이 완료된 것으로 가정합니다.
                                        isShowingProgressView = false
                                    }
                            }
            }
            .fullScreenCover(isPresented: $isShowingSignUp) {
                LoginSignUpView()
            }
        }
        .presentationDetents([.height(UIScreen.main.bounds.height * 0.7)])
    }
    
    func startTask() {
            // 비동기 작업을 시뮬레이션하기 위해 DispatchQueue 사용
            DispatchQueue.global().async {
                // 여기에서 실행 중인 작업 수행
                // ...

                // 작업이 완료되면 메인 스레드에서 UI 업데이트를 수행합니다.
                DispatchQueue.main.async {
                    isShowingProgressView = false // 프로그레스 뷰를 숨깁니다.
                }
            }
        }
}

struct LoginSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSheetView()
            .environmentObject(LoginStore())
    }
}
