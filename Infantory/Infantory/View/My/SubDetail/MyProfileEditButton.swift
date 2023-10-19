//
//  MyProfileEditButton.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyProfileEditButton: View {
    var loginStore: LoginStore
    var body: some View {
        NavigationLink {
                    ProfileEditView(nickName: loginStore.currentUser.nickName, phoneNumber: loginStore.currentUser.phoneNumber, myZipCode: loginStore.currentUser.address.zonecode, myAddress: loginStore.currentUser.address.address, myDetailAddress: loginStore.currentUser.address.addressDetail)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.infanDarkGray, lineWidth: 1)
                            .frame(width: (.screenWidth - 50), height: 30)
                            .foregroundColor(.white)
                        
                        Text("프로필 편집")
                            .font(.infanBody)
                            .foregroundColor(.infanDarkGray)
                    }
                }    }
}

struct MyProfileEditButton_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileEditButton(loginStore: LoginStore())
    }
}
