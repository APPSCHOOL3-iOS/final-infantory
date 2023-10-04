//
//  Empty7.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import Foundation
import SwiftUI

struct LoginMainView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @State private var isShowingLoginSheet: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingLoginSheet = true
            }, label: {
                Text("로그인")
            })
            Text(loginStore.email)
        }
        .sheet(isPresented: $isShowingLoginSheet, content: {
            LoginSheetView()
                .environmentObject(loginStore)
        })
    }
}

struct Empty7_Previews: PreviewProvider {
    static var previews: some View {
        LoginMainView()
            .environmentObject(LoginStore())
    }
}
