//
//  MyMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct MyMainView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @State private var isShowingLoginSheet: Bool = false
    
    var body: some View {
        VStack {
            if loginStore.userUid.isEmpty {
                Button(action: {
                    isShowingLoginSheet = true
                }, label: {
                    Text("로그인")
                })
            } else {
                Button(action: {
                    //
                }, label: {
                    Text("로그아웃")
                })
            }
<<<<<<< HEAD
            Text(loginStore.currentUser.address.addressDetail)
=======
            Text(loginStore.userUid)
>>>>>>> 8a280e5 (Feat: 자동로그인 구현, 데이터 받아오기 하는 중)
        }
        .sheet(isPresented: $isShowingLoginSheet, content: {
            LoginSheetView()
                .environmentObject(loginStore)
        })
    }}

struct MyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyMainView()
            .environmentObject(LoginStore())
    }
}
