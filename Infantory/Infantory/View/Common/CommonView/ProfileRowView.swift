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

            Circle()
                .frame(width: 50)
                .foregroundColor(.gray).opacity(0.2)
                .overlay {
                        CachedImage(url: imageURLString) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                            case .failure:
                                Image(systemName: "smallAppIcon")
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                                
                            @unknown default:
                                EmptyView()
                            }
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
