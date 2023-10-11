//
//  SwiftUIView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/10.
//

import SwiftUI
import Kingfisher

struct MyInfoMainView: View {
    @EnvironmentObject var loginStore: LoginStore
    @StateObject var photosSelectorStore: PhotosSelectorStore = PhotosSelectorStore.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 65, height: 65)
                            .opacity(0.5)
                            .shadow(radius: 10)
                        if let image = photosSelectorStore.profileImage {
                            KFImage(URL(string: image))
                                .onFailure({ error in
                                    print("Error : \(error)")
                                })
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .clipped()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(loginStore.currentUser.name)")// 내 이름
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
                .padding(.leading, 23)
                HStack(spacing: 20) {
                    NavigationLink {
                        // 프로필 관리 버튼 액션
                        ProfileEditView()
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
                        // 배송지 관리
                        Text("배송지 관련 뷰가 보여질 예정입니다.")
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
                
                LazyVStack(alignment: .leading) {
                    NavigationLink {
                        Text("입찰 내역이 보여질 화면입니다.")
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.rectangle.portrait")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 5, height: 25)
                                .horizontalPadding()
                            Text("입찰내역")
                                .frame(height: 50)
                            Spacer()
                        }
                    }
                    Divider()
                    NavigationLink {
                        Text("응모 내역이 보여질 화면입니다.")
                    } label: {
                        HStack {
                            Image(systemName: "ticket")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 5, height: 20)
                                .horizontalPadding()
                            Text("응모내역")
                                .frame(height: 50)
                            Spacer()
                        }
                    }
                    Divider()
                    NavigationLink {
                        Text("결제정보가 보여질 화면입니다.")
                    } label: {
                        HStack {
                            Image(systemName: "tag")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 5, height: 25)
                                .horizontalPadding()
                            Text("결제정보")
                                .frame(height: 50)
                            Spacer()
                        }
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
        .onAppear {
            photosSelectorStore.getProfileImageDownloadURL()
        }
    }
}

struct MyInfoMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoMainView()
            .environmentObject(LoginStore())
    }
}
