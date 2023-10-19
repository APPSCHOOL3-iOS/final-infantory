//
//  InfanFetchUser.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/06.
//

import SwiftUI

struct FetchUser: ViewModifier {
    
    @EnvironmentObject var loginStore: LoginStore
    
    func body(content: Content) -> some View {
        content
            .task {
                Task {
                    if !loginStore.userUid.isEmpty {
                        try await loginStore.fetchUser(userUID: loginStore.userUid)
                    }
                }
            }
    }
}
