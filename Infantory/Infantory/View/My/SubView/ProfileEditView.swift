//
//  ProfileEditView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI

struct ProfileEditView: View {
    //    @StateObject var photosSelectorStore = PhotosSelectorStore.shared
    @StateObject var myStore: MyProfileEditStore = MyProfileEditStore()
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    
    @State var nickName: String = ""
    @State var phoneNumber: String = ""
    @State private var selectedUIImageString: String?
    @State private var selectedUIImage: UIImage?
    @State var image: Image?
    @State var myZipCode: String = ""
    @State var myAddress: String = ""
    @State var myDetailAddress: String = ""
    @State private var showAlert: Bool = false
    @State private var isCheckedNickName: Bool = false
    @State private var isCheckedButton: Bool = false
    @State private var checkNickNameResult: String = ""
    @State private var showToastMessage: Bool = false
    @State private var toastMessageText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    PhotosSelector(selectedUIImage: $selectedUIImage, selectedUIImageString: $selectedUIImageString)
                    VStack(alignment: .leading, spacing: 10) {
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
                    }
                    UnderlineTextField(textFieldTitle: "전화번호",
                                       placeholder: phoneNumber,
                                       text: $phoneNumber)
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            UnderlineTextField(textFieldTitle: "우편 번호", placeholder: myZipCode, text: $myZipCode)
                                .disabled(true)
                            
                            NavigationLink {
                                LoginAddressWebView(zipCode: $myZipCode, address: $myAddress)
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
                        UnderlineTextField(textFieldTitle: "주소", placeholder: myAddress, text: $myAddress)
                            .disabled(true)
                        
                        UnderlineTextField(textFieldTitle: "상세주소", placeholder: myDetailAddress, text: $myDetailAddress)
                    }
                    .padding(.bottom, 30)

                    MainColorButton(text: "변경하기") {
                        Task {
                            if let currentUserId = loginStore.currentUser.id {
                                try await myStore.updateUser(image: selectedUIImage, imageURL: selectedUIImageString, nickName: nickName, phoneNumber: phoneNumber, address: myAddress, zonecode: myZipCode, addressDetail: myDetailAddress, userId: currentUserId)
                                
                                dismiss()
                            }
                        }
                    }
                }
                .padding(.bottom)
                .horizontalPadding()
                .navigationBar(title: "내 프로필 편집")
                .task({
                    
                })
            }
        }
    }
    func mycheckSignUp() {
        if !isCheckedNickName {
            showToastMessage = true
            toastMessageText = "닉네임 중복확인을 해주세요."
        } else if nickName.isEmpty {
            showToastMessage = true
            toastMessageText = "빈칸을 입력해주세요."
        }
    }
}

//struct ProfileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditView(myStore: MyProfileEditStore(), selectedImage: .constant(nil))
//    }
//}
