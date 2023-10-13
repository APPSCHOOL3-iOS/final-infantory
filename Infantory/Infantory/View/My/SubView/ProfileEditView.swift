//
//  ProfileEditView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI

struct ProfileEditView: View {
    //    @StateObject var photosSelectorStore = PhotosSelectorStore.shared
    @ObservedObject var myStore: MyStore
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    @State var nickName: String = ""
    @State var phoneNumber: String = ""
    
    @State private var selectedUIImageString: String?
    @State private var selectedUIImage: UIImage?
    @Binding var selectedImage: Image?
    @State var image: Image?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    PhotosSelector(selectedUIImageString: $selectedUIImageString, selectedImage: $selectedImage)
                    UnderlineTextField(textFieldTitle: "닉네임",
                                       placeholder: "변경할 닉네임을 입력해주세요",
                                       text: $nickName)
                    UnderlineTextField(textFieldTitle: "전화번호",
                                       placeholder: "변경할 전화번호을 입력해주세요",
                                       text: $phoneNumber)
                    Spacer()
                    MainColorButton(text: "변경하기") {
                        if let selectedUIImage = selectedUIImage {
                            image = Image(uiImage: selectedUIImage)
                            selectedImage = image
                            print("변경됨?")
                        }
                        Task {
                            if let currentUserId = loginStore.currentUser.id {
                                try await myStore.updateUser(userId: currentUserId,
                                                             image: selectedUIImage,
                                                             imagename: selectedUIImageString,
                                                             nickName: nickName,
                                                             phoneNumber: phoneNumber) {_ in
                                    print("유저 업데이트 됨")
                                }
                            }
                        }
                        //                    dismiss()
                    }
                }
                .padding(.bottom)
                .horizontalPadding()
                .navigationBar(title: "내 프로필 편집")
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(myStore: MyStore(), selectedImage: .constant(nil))
    }
}
