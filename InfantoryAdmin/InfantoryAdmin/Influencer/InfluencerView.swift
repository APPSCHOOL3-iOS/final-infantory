//
//  InfluencerView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

struct InfluencerView: View {
    
    @StateObject private var influencerStore: InfluencerStore = InfluencerStore()
    @State private var isInfluencerAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var userID: String = ""
    @State private var userType: UserType = .user
    
    @State private var searchNickName: String = ""
    @State private var isLoading = false
    
    @State private var isShowToastMessage: Bool = false
    var body: some View {
            VStack {
                TextField("닉네임을 검색하세요.", text: $searchNickName)
                    .padding()
                ScrollView {
                    ForEach(searchNickName.isEmpty ? influencerStore.userList : influencerStore.userList.filter{$0.nickName.contains(searchNickName)}) { user in
                        HStack {
                            AsyncImage(url: URL(string: user.profileImageURLString ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                            } placeholder: {
                                Image("smallAppIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                            }
                            Text(user.nickName)
                                .foregroundColor(.black)
                            Spacer()
                            Button {
                                alertTitle = user.isInfluencer == .user ? "유저 → 인플루언서" : "인플루언서 → 유저"
                                alertMessage = user.isInfluencer == .user ? "\(user.nickName)님을 인플루언서로 등록하시겠습니까?" : "\(user.nickName)님을 유저로 등록하시겠습니까?"
                                userID = user.id ?? ""
                                userType = user.isInfluencer
                                isInfluencerAlert = true
                                isLoading = true
                            } label: {
                                Image(systemName: user.isInfluencer == .user ? "square" : "checkmark.square.fill")
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
                ToastMessageView(content: Text("등록이 완료되었습니다."), isPresented: $isShowToastMessage)
        }
        .alert(isPresented: $isInfluencerAlert) {
            Alert(title: Text("\(alertTitle)"),
                  message: Text("\(alertMessage)"),
                  primaryButton: .default(Text("취소")),
                  secondaryButton: .default(Text("등록")) {
                influencerStore.userTypeChange(userID: userID, isInfluencer: userType)
                isShowToastMessage = true
            })
        }
        .task {
            Task {
                try await influencerStore.fetchUser()
            }
        }
        .refreshable {
            Task {
                try await influencerStore.fetchUser()
            }
        }
    }
}
