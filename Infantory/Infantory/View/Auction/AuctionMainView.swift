//
//  AuctionMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct AuctionMainView: View {
    var body: some View {
            VStack {
                HStack {
                    Text("Infantory")
                        .font(.infanTitle)
                        .foregroundColor(.infanDarkGray)
                    Spacer()
                    Button {
                        // SearchView 검색창 (네비게이션으로 변경해야할 것 같습니다.)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.infanDarkGray)
                    }
                    Button {
                        // alramView 알람창 (네비게이션으로 변경 해야할 것 같습니다.)
                    } label: {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.infanDarkGray)
                    }
                }
                .padding([.horizontal, .bottom])
                Divider()
                ScrollView {
                    // Hstack 부터 뷰 나누면 될 것 같습니다.
                HStack {
                    Button(action: {}, label: {
                        Text("진행경매")
                            .frame(width: 95, height: 30)
                            .foregroundColor(.infanLightGray)
                            .background(Color.infanDarkGray)
                            .cornerRadius(15)
                    })
                    Button(action: {}, label: {
                        Text("예정경매")
                            .frame(width: 95, height: 30)
                            .foregroundColor(.infanDarkGray)
                            .background(Color.infanLightGray)
                            .cornerRadius(15)
                    })
                    Spacer()
                }
                .padding(.horizontal)
                // Vstack 부터 뷰 나누면 될 것 같습니다.
                    VStack {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                            Text("오킹")
                            Spacer()
                            Image(systemName: "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        }
                        .padding([.horizontal, .top])
                        Button {
                            
                        } label: {
                            HStack {
                                Image("Shose1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 160)
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("Hot")
                                            .font(.infanFootnote)
                                            .frame(width: 40, height: 20)
                                            .foregroundColor(.infanDarkGray)
                                            .background(Color.infanRed)
                                            .cornerRadius(10)
                                        Text("New")
                                            .font(.infanFootnote)
                                            .frame(width: 40, height: 20)
                                            .foregroundColor(.infanDarkGray)
                                            .background(Color.infanGreen)
                                            .cornerRadius(10)
                                    }
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("상품명: ")
                                            .font(.infanTitle2)
                                            .foregroundColor(.infanDarkGray)
                                            .padding(.bottom)
                                        Text("남은시간: ")
                                            .font(.infanBody)
                                            .foregroundColor(.infanDarkGray)
                                        Text("현재 입찰가: ")
                                            .font(.infanBody)
                                            .foregroundColor(.infanDarkGray)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                Divider()
            }
        }
    }
}

struct AuctionMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionMainView()
    }
}
