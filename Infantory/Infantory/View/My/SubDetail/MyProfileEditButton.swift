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
            Text("편집")
                .font(.infanFootnote)
                .foregroundColor(.infanBlack)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.infanLightGray, lineWidth: 1)
                )
        }
        .padding(.trailing)
    }
}

struct MyProfileEditButton_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileEditButton(loginStore: LoginStore())
    }
}
