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
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(50)
                        .padding(.leading, 25)
                    VStack(alignment: .leading) {
                        Text("봉주헌\(loginStore.currentUser.name)")// 내 이름
                            .font(.infanTitle2)
                            .padding(.bottom, 1)
                        //                            Text("\(loginStore.currentUser.email)")// 내 이메일
                        HStack {
                            Text("응모권")
                            Text("\(loginStore.totalApplyTicketCount)")
                                .font(.infanHeadlineBold)
                            Text("관심상품")
                            Text("0")
                                .font(.infanHeadlineBold)
                        }
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.trailing)
                HStack(spacing: 20) {
                    NavigationLink {
                        // 프로필 관리 버튼 액션
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 160, height: 30)
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
                                .frame(width: 160, height: 30)
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
                    HStack(alignment: .top) {
                        Text("최근 주문 내역")
                            .font(.infanHeadlineBold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack {
                        VStack(spacing: 5) {
                            Text("0")
                                .font(.infanTitle2)
                            Text("결제완료")
                                .font(.infanFootnote)
                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.infanLightGray)
                        .foregroundColor(.infanGray)
                        .cornerRadius(10)
                        VStack(spacing: 5) {
                            Text("0")
                                .font(.infanTitle2)
                            Text("준비중")
                                .font(.infanFootnote)
                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.infanLightGray)
                        .foregroundColor(.infanGray)
                        .cornerRadius(10)
                        VStack(spacing: 5) {
                            Text("0")
                                .font(.infanTitle2)
                            Text("배송중")
                                .font(.infanFootnote)
                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.infanLightGray)
                        .foregroundColor(.infanGray)
                        .cornerRadius(10)
                        VStack(spacing: 5) {
                            Text("0")
                                .font(.infanTitle2)
                            Text("배송완료")
                                .font(.infanFootnote)
                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.infanLightGray)
                        .foregroundColor(.infanGray)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                Divider()
                
                LazyVStack {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.rectangle.portrait")
                                .imageScale(.large)
                            Text("입찰내역")
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
                            Text("고객센터") // 관심상품이 있는데 굳이?
                                .frame(height: 50)
                            Spacer()
                        }
                    }
                    Divider()
                    
                    HStack {
                        Image(systemName: "tag")
                            .imageScale(.large)
                        Text("결제정보")
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
                        Spacer()
                    }
                    .padding(.horizontal)
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
