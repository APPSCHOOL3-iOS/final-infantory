//
//  SwiftUIView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/10.
//

import SwiftUI

struct MySubView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("이름")// 내 이름
                    .font(.largeTitle)
                    .padding(5)
                Text("이메일: ")// 내 전화번호
                
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                    VStack {
                        Text("0")
                            .font(.largeTitle)
                            .bold()
                        Text("응모권")
                            .font(.footnote)
                    }
                    .padding()
                    Spacer()
                    VStack(alignment: .center) {
                        Text("0")
                            .font(.largeTitle)
                            .bold()
                        Text("관심상품")
                            .font(.footnote)
                    }
                    .padding()
                    Spacer()
                }
                // 자세히보기 버튼
                HStack(spacing: 20) {
                    NavigationLink {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 150, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.infanMain, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .padding(2)
                            Text("프로필 관리")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanMain)
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 150, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.infanMain, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .padding(2)
                            Text("배송지 관리")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanMain)
                        }
                    }
                }
                VStack {
                    Button {
                        //                    isOpenMapSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.rectangle.portrait")
                                .imageScale(.large)
                                .padding()
                            Text("주소 관리")
                                .frame(height: 60)
                            Spacer()
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Image(systemName: "heart")
                                .imageScale(.large)
                                .padding()
                            Text("즐겨찾기")
                                .frame(height: 60)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Image(systemName: "tag")
                            .imageScale(.large)
                            .padding()
                        Text("보유 금액")
                            .frame(height: 60)
                        Spacer()
                        Spacer()
                        Text("100000원")
                        Spacer()
                    }
                }
                .foregroundColor(.primary)
                .listStyle(.plain)
            }
        }
    }
}

struct MySubView_Previews: PreviewProvider {
    static var previews: some View {
        MySubView()
    }
}
