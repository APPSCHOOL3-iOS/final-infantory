//
//  MyUserProfileView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyUserProfileView: View {
    var loginStore: LoginStore
    var body: some View {
        HStack(spacing: 16) {
            CachedImage(url: loginStore.currentUser.profileImageURLString ?? "") { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                case .failure:
                    Image("smallAppIcon")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                Text("\(loginStore.currentUser.nickName)")
                    .font(.infanTitle2)
                    .foregroundColor(.infanBlack)
                    Spacer()
                    Image("applyTicket")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .aspectRatio(contentMode: .fit)
                    Text(": \(loginStore.totalApplyTicketCount) 장")
                        .font(.infanHeadline)
                        .foregroundColor(.infanBlack)
                }
            }
            Spacer()
        }
    }
}

struct MyUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyUserProfileView(loginStore: LoginStore())
    }
}
