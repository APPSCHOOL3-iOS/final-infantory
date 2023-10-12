//
//  MyAddressDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/12.
//

import SwiftUI

struct MyAddressDetailView: View {
    @EnvironmentObject var loginStore: LoginStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(loginStore.currentUser.name)")
                .font(.infanHeadlineBold)
                .padding(.vertical, 3)
            Text("(\(loginStore.currentUser.address.address))")
            Text("\(loginStore.currentUser.address.zonecode)")
            Text("\(loginStore.currentUser.address.addressDetail)")
        }
        .font(.infanBody)
    }
}

struct MyAddressDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyAddressDetailView()
            .environmentObject(LoginStore())
    }
}
