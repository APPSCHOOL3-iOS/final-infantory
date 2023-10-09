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
            VStack(alignment: .leading, spacing: 20) {
    
                UnderlineTextField(textFieldTitle: "이메일", placeholder: loginStore.userName, text: $email)
                    .disabled(false)
                
                VStack(alignment: .leading) {
                    HStack {
                        
                        UnderlineTextField(textFieldTitle: "닉네임", placeholder: loginStore.userName, text: $nickName)
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
                            VStack {
                                Text(" ")
                                    .font(.infanFootnote)
                                Text("중복확인")
                                    .font(.infanFootnote)
                                    .padding(6)
                                    .foregroundColor(.white)
                                    .background(Color.infanMain)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    Text(checkNickNameResult)
                        .font(.infanFootnote)
                        .foregroundColor(isCheckedNickName ? .infanGreen : .infanRed)
                        .padding(.bottom)
                }
            
                UnderlineTextField(textFieldTitle: "휴대폰 번호",
                               placeholder: "- 없이 입력",
                               text: $phoneNumber)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        
                        UnderlineTextField(textFieldTitle: "우편 번호", placeholder: "우편 번호를 검색하세요", text: $zipCode)
                            .disabled(true)
                        
                        NavigationLink {
                            LoginAddressWebView(zipCode: $zipCode, address: $address)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            VStack {
                                Text(" ")
                                    .font(.infanFootnote)
                                Text("우편번호")
                                    .font(.infanFootnote)
                                    .padding(6)
                                    .foregroundColor(.white)
                                    .background(Color.infanMain)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    UnderlineTextField(textFieldTitle: "주소", placeholder: "우편 번호 검색 후, 자동 입력 됩니다", text: $address)
                        .disabled(true)
                    
                    UnderlineTextField(textFieldTitle: "상세주소", placeholder: "건물, 아파트, 동/호수 입력", text: $detailAddress)
                }
                .padding(.bottom, 30)
                
                HStack {
                    Spacer()
                    Button {
                        checkSignUp()
                    } label: {
                        Text("가입하기")
                            .font(.infanHeadlineBold)
                            .frame(width: .screenWidth * 0.9, height: .screenHeight * 0.06)
                            .foregroundColor(.white)
                            .background(Color.infanMain)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            .padding()
            .navigationBar(title: "회원가입")
            
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


struct LoginSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginSignUpView()
                .environmentObject(LoginStore())
        }
    }
}
