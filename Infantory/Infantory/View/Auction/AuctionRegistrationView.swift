//
//  AuctionRegistrationView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/20.
//

import SwiftUI

struct AuctionRegistrationView: View {
    @State private var title: String = ""
    @State private var apply: String = ""
    @State private var itemDescription: String = ""
    @State private var startingPrice: String = ""
    @State private var maximumPrice: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                HStack {
                    // 네비게이션링크를 사용하면 백버튼이 생성됨
//                    Image(systemName: "xmark")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 20, height: 20)
                    Spacer()
                    Text("내 경매 등록")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("상품 사진")
                        .font(.system(size: 17))
                        .bold()
                    ItemIamgeView()
                }
                .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text("착장 사진")
                        .font(.system(size: 17))
                        .bold()
                    InfluencerImageCell()
                }
                .padding(.leading)
                
                VStack(spacing: 20) {
                    Group {
                        TextField("제목", text: $title)
                        Divider()
                        TextField("응모시작일", text: $apply)
                        Divider()
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.gray)
                                .frame(width: 360, height: 140)
                            TextField("애장품 설명", text: $itemDescription)
                                .padding([.leading, .top])
                        }
                        TextField("시작가", text: $startingPrice)
                        Divider()
                        TextField("최고가", text: $maximumPrice)
                        Divider()
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.black)
                            .frame(width: 360, height: 40)
                        Button {
                            
                        } label: {
                            Text("작성 완료")
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
            }
        }
    }
}

struct AuctionRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionRegistrationView()
    }
}
