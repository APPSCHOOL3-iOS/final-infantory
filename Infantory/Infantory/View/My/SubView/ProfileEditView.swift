//
//  ProfileEditView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI
import PhotosUI
import Photos

struct ProfileEditView: View {
    //    @StateObject var photosSelectorStore = PhotosSelectorStore.shared
    @ObservedObject var myProfileEditStore: MyProfileEditStore
    
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    
    @State var nickName: String = ""
    @State var phoneNumber: String = ""
    @State var selectedUIImageString: String?
    @State var selectedUIImage: UIImage?
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
    
    @State private var cameraSheetShowing = false
    @State var showImagePicker = false
//    @Binding var selectedUIImage: UIImage?
//    @Binding var selectedUIImageString: String?
//    
    @State var selectedImage: Image?
//    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        print("이미지 넘어옴")
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
//                    PhotosSelector(myProfileEditStore: myProfileEditStore, selectedUIImage: $selectedUIImage, selectedUIImageString: $selectedUIImageString)
                    CachedImage(url: loginStore.currentUser.profileImageURLString ?? "") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 80)
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                        case .failure:
                            Image("smallAppIcon")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    VStack {
                        HStack(alignment: .top) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 160, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.infanDarkGray, lineWidth: 1)
                                    )
                                    .foregroundColor(.white)
                                    .padding(2)
                                Button {
                                    cameraSheetShowing = true
                                } label: {
                                    Text("사진촬영")
                                        .font(.infanBody)
                                        .foregroundColor(.infanDarkGray)
                                }
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 160, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.infanDarkGray, lineWidth: 1)
                                    )
                                    .foregroundColor(.white)
                                    .padding(2)
                                Button {
                                    showImagePicker.toggle()
                                } label: {
                                    Text("앨범에서 선택")
                                        .font(.infanBody)
                                        .foregroundColor(.infanDarkGray)
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            
                            UnderlineTextField(textFieldTitle: "닉네임", placeholder: myProfileEditStore.user?.nickName ?? "", text: $nickName)
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
                                       placeholder: loginStore.currentUser.phoneNumber,
                                       text: $phoneNumber)
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            UnderlineTextField(textFieldTitle: "우편 번호", placeholder: loginStore.currentUser.address.zonecode, text: $myZipCode)
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
                        UnderlineTextField(textFieldTitle: "주소", placeholder: loginStore.currentUser.address.address, text: $myAddress)
                            .disabled(true)
                        
                        UnderlineTextField(textFieldTitle: "상세주소", placeholder: loginStore.currentUser.address.addressDetail, text: $myDetailAddress)
                    }
                    .padding(.bottom, 30)

                    MainColorButton(text: "변경하기") {
                        Task {
                            if let currentUserId = loginStore.currentUser.id {
                                try await myProfileEditStore.updateUser(image: selectedUIImage, imageURL: selectedUIImageString, nickName: nickName, phoneNumber: phoneNumber, address: myAddress, zonecode: myZipCode, addressDetail: myDetailAddress, userId: currentUserId)
                                
                                dismiss()
                            }
                        }
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    loadImage()
                }) {
                    ProfileImagePicker(selectedUIImageString: $selectedUIImageString, selectedUIImage: $selectedUIImage)
                }
                .sheet(isPresented: $cameraSheetShowing) {
                    UseCameraView()
                }
                .padding(.bottom)
                .horizontalPadding()
                .navigationBar(title: "내 프로필 편집")
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
