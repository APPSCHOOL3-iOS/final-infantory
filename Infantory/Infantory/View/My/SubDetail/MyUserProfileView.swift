//
//  MyTextView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/20.
//

import SwiftUI

struct MyUserProfileView: View {
    @ObservedObject var myProfileEditStore: MyProfileEditStore
    @EnvironmentObject var loginStore: LoginStore
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: loginStore.currentUser.profileImageURLString ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(45)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text("\(loginStore.currentUser.nickName)")
                HStack {
                    NavigationLink {
                        EntryTicketView()
                    } label: {
                        Text("응모권: ")
                        Text("\(loginStore.totalApplyTicketCount)장")
                            .font(.infanFootnoteBold)
                            .foregroundColor(.infanMain)
                            .padding(.leading, -5)
                    }
                    Divider()
                        .frame(height: 15)
                        .background(Color.gray)
                    NavigationLink {
                        Text("내가 팔로우한 인플루언서가 보여질 예정입니다.")
                    } label: {
                        Text("팔로잉: ")
                        Text("\(myProfileEditStore.user?.follower?.count ?? 0)")
                            .font(.infanFootnoteBold)
                            .foregroundColor(.infanMain)
                            .padding(.leading, -5)
                    }
                }
                .font(.infanFootnote)
                .foregroundColor(.infanBlack)
            }
        }
        Spacer()
    }
}

struct MyUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyUserProfileView(myProfileEditStore: MyProfileEditStore())
    }
}
