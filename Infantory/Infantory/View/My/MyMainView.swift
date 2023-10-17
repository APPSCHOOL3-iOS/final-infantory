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
        NavigationStack {
            if loginStore.userUid.isEmpty {
                MyLoginView()
            } else {
                MyInfoMainView()
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
