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
    @State private var myZipCode: String = ""
    @State private var myAddress: String = ""
    @State private var myDetailAddress: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    PhotosSelector(selectedUIImage: $selectedUIImage, selectedUIImageString: $selectedUIImageString)
                    UnderlineTextField(textFieldTitle: "닉네임",
                                       placeholder: nickName,
                                       text: $nickName)
                    UnderlineTextField(textFieldTitle: "전화번호",
                                       placeholder: phoneNumber,
                                       text: $phoneNumber)
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            UnderlineTextField(textFieldTitle: "우편 번호", placeholder: "우편 번호를 검색하세요", text: $myZipCode)
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
                        UnderlineTextField(textFieldTitle: "주소", placeholder: "우편 번호 검색 후, 자동 입력 됩니다", text: $myAddress)
                            .disabled(true)
                        
                        UnderlineTextField(textFieldTitle: "상세주소", placeholder: "건물, 아파트, 동/호수 입력", text: $myDetailAddress)
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
            }
        }
    }
}
//
//struct ProfileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditView(myStore: MyProfileEditStore(), selectedImage: .constant(nil))
//    }
//}
