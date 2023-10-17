//
//  ProfileRowView.swift
//  Infantory
//
//  Created by 변상필 on 10/6/23.
//

import SwiftUI

struct ProfileRowView: View {
    let imageURLString: String
    let nickname: String

    @State private var isShowingSheet: Bool = false

    var body: some View {
        HStack {

            CachedImage(url: imageURLString) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .scaledToFill()
                        .frame(width: (.screenWidth - 100) / 2,
                               height: (.screenWidth - 100) / 2)
                        .clipped()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                    //
                case .failure:
                    Image("smallAppIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                    
                @unknown default:
                    EmptyView()
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
        ProfileRowView(imageURLString: "", nickname: "상필갓")
    }
}
