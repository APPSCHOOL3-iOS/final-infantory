//
//  MyTextView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/20.
//

import SwiftUI

struct MyTextView: View {
    @ObservedObject var myProfileEditStore: MyProfileEditStore
    var loginStore: LoginStore
    
    var body: some View {
        HStack {
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
                        Text("15K")
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

struct MyTextView_Previews: PreviewProvider {
    static var previews: some View {
        MyTextView(myProfileEditStore: MyProfileEditStore(), loginStore: LoginStore())
    }
}
