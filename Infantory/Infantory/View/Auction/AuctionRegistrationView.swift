//
//  AuctionRegistrationView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/20.
//

import SwiftUI

struct AuctionRegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var registViewModel = AuctionProductViewModel()
    @State private var title: String = ""
    @State private var apply: String = ""
    @State private var itemDescription: String = ""
    @State private var startingPrice: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isShowAlert: Bool = false
    
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
                            .autocapitalization(.none)
                        Divider()
                        TextField("응모시작일", text: $apply)
                            .autocapitalization(.none)
                        Divider()
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.gray)
                                .frame(width: 360, height: 140)
                            TextField("애장품 설명", text: $itemDescription)
                                .autocapitalization(.none)
                                .padding([.leading, .top])
                        }
                        TextField("시작가", text: $startingPrice)
                            .autocapitalization(.none)
                        Divider()
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.black)
                            .frame(width: 360, height: 40)
                        Button {
                            if title.isEmpty {
                                showAlert = true
                                alertMessage = "제목을 입력해주세요."
                            } else if itemDescription.isEmpty {
                                showAlert = true
                                alertMessage = "상품 설명을 입력해주세요."
                            } else if startingPrice.isEmpty {
                                showAlert = true
                                alertMessage = "시작가를 입력해주세요."
                            } else {
                                Task {
                                    try await registViewModel.createAuctionProduct(title: title, apply: apply, itemDescription: itemDescription, startingPrice: startingPrice)
                                }
                            }
                            //                            dismiss()
                        } label: {
                            Text("작성 완료")
                                .frame(width: 360, height: 40)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }
            }
        }
    }
}

struct AuctionRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionRegistrationView()
    }
}
