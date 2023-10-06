//
//  ProfileRowView.swift
//  Infantory
//
//  Created by 변상필 on 10/6/23.
//

import SwiftUI

struct ProfileRowView: View {
    let imageURLString: String = ""
    let nickname: String = "희찬 갓갓"

    @State private var isShowingSheet: Bool = true

    var body: some View {
        HStack {

            Circle()
                .frame(width: 70)

            Text("(nickname)")

            Spacer()

            Button(action: {
                isShowingSheet.toggle()
            }, label: {
                Image(systemName: "ellipsis")
            })
            .buttonStyle(.plain)

        }
        .infanHorizontalPadding()
        .sheet(isPresented: $isShowingSheet, content: {
            ProfileSheetView()
        })
    }
}

struct ProfileRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRowView()
    }
}
