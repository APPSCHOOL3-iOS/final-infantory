//
//  ProfileRowView.swift
//  Infantory
//
//  Created by 변상필 on 10/6/23.
//

import SwiftUI

struct ProfileRowView: View {
    let imageURLString: String = "https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000401.png"
    let nickname: String

    @State private var isShowingSheet: Bool = false

    var body: some View {
        HStack {

            Circle()
                .frame(width: 50)
                .foregroundColor(.gray).opacity(0.2)
                .overlay {
                    AsyncImage(url: URL(string: imageURLString)!) { image in
                        image.image?
                            .resizable()
                    }
                }

            Text(nickname)

            Spacer()

            Button(action: {
                isShowingSheet.toggle()
            }, label: {
                Image(systemName: "ellipsis")
            })
            .buttonStyle(.plain)

        }
        .horizontalPadding()
        .sheet(isPresented: $isShowingSheet, content: {
            ProfileSheetView()
        })
    }
}

struct ProfileRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRowView(nickname: "상필갓")
    }
}
