//
//  ProfileEditView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI

struct ProfileEditView: View {
    @StateObject var photoStore: PhotosSelectorStore = PhotosSelectorStore.shared
    @State var profileName: String = ""
    @State var name: String = ""
    @State var phoneNumber: String = ""
      
    var body: some View {
        NavigationStack {
        ScrollView {
                VStack {
                    PhotosSelector()
                    UnderlineTextField(textFieldTitle: "닉네임",
                                       placeholder: "변경할 닉네임을 입력해주세요",
                                       text: $profileName)
                    UnderlineTextField(textFieldTitle: "전화번호",
                                       placeholder: "변경할 전화번호을 입력해주세요",
                                       text: $phoneNumber)
                }
                .horizontalPadding()
            }
            .navigationBar(title: "내 프로필 편집")
            .onAppear {
                photoStore.getProfileImageDownloadURL()
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
