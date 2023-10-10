//
//  SwiftUIView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/10.
//

import SwiftUI

struct MyInfoMainView: View {
    @EnvironmentObject var loginStore: LoginStore
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(spacing: 20) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .cornerRadius(50)
                            .padding(.leading)
                        VStack(alignment: .leading) {
                            Text("봉주헌")
//                            Text("봉주헌\(loginStore.currentUser.name)")// 내 이름
                                .font(.infanTitle2)
                                .padding(.bottom, 5)
//                            Text("\(loginStore.currentUser.email)")// 내 이메일
                            HStack {
                                Text("응모권")
                                Text("0")
                                    .font(.infanHeadlineBold)
                                Text("관심상품")
                                Text("0")
                                    .font(.infanHeadlineBold)
                            }
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.horizontal)
                HStack(spacing: 20) {
                    NavigationLink {
                        // 프로필 관리 버튼 액션
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 150, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.infanDarkGray, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .padding(2)
                            Text("프로필 관리")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                    NavigationLink {
                        // 배송지 관리 버튼 액션
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 150, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.infanDarkGray, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .padding(2)
                            Text("배송지 관리")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                VStack {
                    Button {
                        //                    isOpenMapSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.rectangle.portrait")
                                .imageScale(.large)
                                .padding()
                            Text("이용약관")
                                .frame(height: 50)
                            Spacer()
                        }
                    }
                    Divider()
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Image(systemName: "heart")
                                .imageScale(.large)
                                .padding()
                            Text("즐겨찾기")
                                .frame(height: 50)
                            Spacer()
                        }
                    }
                    Divider()
                    
                    HStack {
                        Image(systemName: "tag")
                            .imageScale(.large)
                            .padding()
                        Text("오픈소스 라이선스")
                            .frame(height: 50)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Button(action: {
                            loginStore.kakaoLogout()
                        }, label: {
                            Text("로그아웃")
                                .frame(height: 50)
                                .foregroundColor(.infanRed)
                        })
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.primary)
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("")
        }
    }
}

struct MyInfoMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoMainView()
            .environmentObject(LoginStore())
    }
}
