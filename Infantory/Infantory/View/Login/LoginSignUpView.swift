//
//  LoginSignUpView.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/20.
//

import SwiftUI

struct LoginSignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var loginStore: LoginStore
    @State private var email: String = ""
    @State private var nickName: String = ""
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var zipCode: String = ""
    @State private var address: String = ""
    @State private var detailAddress: String = ""
    @State private var isCheckedNickName: Bool = false
    @State private var checkNickNameResult: String = ""
    @State private var showToastMessage: Bool = false
    @State private var toastMessageText: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("*이메일") // 소셜로그인하면서 받아올 예정
                TextField("\(loginStore.email)", text: $email)
                    .overlay(UnderLineOverlay())
                    .padding(.bottom)
                    .disabled(true)
                
                Group {
                    Text("*닉네임")
                    HStack {
                        TextField("\(loginStore.userName)", text: $nickName)
                            .overlay(UnderLineOverlay())

                        Button {
                            loginStore.duplicateNickName(nickName: nickName) { result in
                                if nickName == "" {
                                    isCheckedNickName = false
                                    checkNickNameResult = "닉네임을 입력해주세요."
                                } else if result {
                                    isCheckedNickName = true
                                    checkNickNameResult = "사용 가능한 닉네임입니다."
                                } else {
                                    isCheckedNickName = false
                                    checkNickNameResult = "중복된 닉네임입니다."
                                }
                            }
                        } label: {
                            Text("중복확인")
                                .padding(5)
                                .foregroundColor(.white)
                                .background(Color.infanMain.opacity(0.8))
                                .cornerRadius(5)
                        }
                    }
                    Text(checkNickNameResult)
                        .font(Font.infanFootnote)
                        .foregroundColor(isCheckedNickName ? .infanGreen : .infanRed)
                        .padding(.bottom)
                }
                
                Text("이름")
                TextField("\(loginStore.userName)", text: $name)
                    .overlay(UnderLineOverlay())
                    .padding(.bottom)
                
                Text("휴대폰 번호")
                TextField("- 없이 입력", text: $phoneNumber)
                    .overlay(UnderLineOverlay())
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                        Text("우편 번호") // 우편번호 검색 버튼 만들 예정
                    HStack {
                        TextField("우편 번호를 검색하세요", text: $zipCode)
                            .overlay(UnderLineOverlay())
                            .padding(.bottom)
                            .disabled(true)
                        
                        NavigationLink {
                            LoginAddressWebView(zipCode: $zipCode, address: $address)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("우편번호")
                                .padding(5)
                                .foregroundColor(.white)
                                .background(Color.infanMain.opacity(0.8))
                                .cornerRadius(5)
                        }
                    }
                    
                    Text("주소")
                    TextField("우편 번호 검색 후, 자동입력 됩니다.", text: $address)
                        .overlay(UnderLineOverlay())
                        .padding(.bottom)
                        .disabled(true)
                    
                    Text("상세주소")
                    TextField("건물, 아파트, 동/호수 입력", text: $detailAddress)
                        .overlay(UnderLineOverlay())
                        .padding(.bottom)
                }
                .padding(.bottom, 30)
                
                HStack {
                    Spacer()
                    Button {
                        checkSignUp()
                    } label: {
                        Text("가입하기")
                            .font(Font.infanTitle2Bold)
                            .frame(width: .screenWidth * 0.9, height: .screenHeight * 0.06)
                            .foregroundColor(.white)
                            .background(Color.infanMain.opacity(0.8))
                            .cornerRadius(5)
                    }
                    Spacer()
                }
            }
            .padding()
            .infanNavigationBar(title: "회원가입")
            .overlay(
                ToastMessage(content: Text("\(toastMessageText)"), isPresented: $showToastMessage)
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("회원가입 성공"), message: Text("회원가입에 성공했습니다. 로그인을 다시 해주세요."), dismissButton: .default(Text("확인")) {
                    dismiss()
                })
            }
        }
    }
    
    func signUpToFirebase() {
        loginStore.signUpToFirebase(
            name: name,
            nickName: nickName,
            phoneNumber: phoneNumber,
            zipCode: zipCode,
            streetAddress: address,
            detailAddress: detailAddress,
            completion: { result in
                if result {
                    showAlert = true
                } else {
                    showToastMessage = true
                    toastMessageText = "회원가입에 실패했습니다. 다시 시도해주세요."
                }
            })
    }
    
    func checkSignUp() {
        if !isCheckedNickName {
            showToastMessage = true
            toastMessageText = "닉네임 중복확인을 해주세요."
        } else if nickName.isEmpty || name.isEmpty || phoneNumber.isEmpty || zipCode.isEmpty || address.isEmpty || detailAddress.isEmpty {
            showToastMessage = true
            toastMessageText = "빈칸을 입력해주세요."
        } else {
            signUpToFirebase()
        }
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
                .environmentObject(LoginStore())
        }
    }
}
