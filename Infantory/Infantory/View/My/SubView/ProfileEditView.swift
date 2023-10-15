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
                    MainColorButton(text: "변경하기") {
//                        if let selectedUIImage = selectedUIImage {
//                            image = Image(uiImage: selectedUIImage)
//                            selectedImage = image
//                        }
                        Task {
                            if let currentUserId = loginStore.currentUser.id {
                                try await myStore.updateUser(image: selectedUIImage,
                                                             imageURL: selectedUIImageString,
                                                             nickName: nickName,
                                                             phoneNumber: phoneNumber,
                                                             userId: currentUserId)
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
