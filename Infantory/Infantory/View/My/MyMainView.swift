//
//  MyMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct MyMainView: View {
    @StateObject var myProfileEditStore: MyProfileEditStore = MyProfileEditStore()
    @StateObject var myPaymentStore: MyPaymentStore = MyPaymentStore()
    @EnvironmentObject var loginStore: LoginStore
    @State private var isShowingLoginSheet: Bool = false
    @State private var selectedUIImage: UIImage?
    @State private var selectedUIImageString: String?
    
    var body: some View {
        NavigationStack {
            if loginStore.userUid.isEmpty {
                MyLoginView()
            } else {
                MyInfoMainView(nickName: myProfileEditStore.user?.nickName ?? "")
            }
        }
        .onAppear {
            if !loginStore.userUid.isEmpty {
                myProfileEditStore.fetchUser(userID: loginStore.userUid)
            }
        }
    }
}

struct MyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyMainView()
            .environmentObject(LoginStore())
    }
}
