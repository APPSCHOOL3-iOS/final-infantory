//
//  AuctionRegistrationView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/20.
//

import SwiftUI

struct AuctionRegistrationView: View {
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    @StateObject var registViewModel = AuctionRegisterStore()
    @State private var title: String = ""
    @State private var apply: String = ""
    @State private var itemDescription: String = ""
    @State private var startingPrice: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isShowAlert: Bool = false
    @State private var auctionProductSelectedImages: [UIImage] = []
    @State private var auctionProductSelectedImageNames: [String] = []
    @State private var auctionCustumeSelectedImages: [UIImage] = []
    @State private var auctionCustumeSelectedImageNames: [String] = []
    
    var body: some View {
        ScrollView {

            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("상품 사진")
                        .font(.infanHeadlineBold)
                        
                    ApplyImagePickerView(selectedImages: $auctionProductSelectedImages, selectedImageNames: $auctionProductSelectedImageNames)
                }
                
                VStack(alignment: .leading) {
                    Text("착장 사진")
                        .font(.infanHeadlineBold)
                        
                    ApplyImagePickerView(selectedImages: $auctionCustumeSelectedImages, selectedImageNames: $auctionCustumeSelectedImageNames)
                }
                
                VStack(spacing: 16) {
                    
                    InfanTextField(textFieldTitle: "애장품",
                                   placeholder: "애장품 이름을 입력해주세요.",
                                   text: $title)
                    
                    InfanTextEditor(textFieldTitle: "소개",
                                    placeHolder: "애장품을 소개해주세요.",
                                    text: $itemDescription)
                    
                    //TODO: 경매시작, 종료일도 받아야함 + 시작일은 TextField가 아닌 Date로 받아야 하고, 시작가는 Int 키보드로 받기.
                    TextField("경매시작", text: $apply)
                        .autocapitalization(.none)
                    
                    TextField("시작가", text: $startingPrice)
                        .keyboardType(.numberPad)
                    
                    Divider()
                    
                    Spacer()
                    
                    InfanMainButton(text: "등록하기") {
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
                            let product = registViewModel.makeAuctionModel(title: title,
                                                                           apply: apply,
                                                                           itemDescription: itemDescription,
                                                                           startingPrice: startingPrice,
                                                                           imageStrings: auctionProductSelectedImageNames + auctionCustumeSelectedImageNames,
                                                                           user: loginStore.currentUser)
                            
                            Task {
                                try await registViewModel.addAuctionProduct(auctionProduct: product, images: auctionProductSelectedImages + auctionCustumeSelectedImages, completion: {_ in dismiss()
                                })
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }
            }
            .infanHorizontalPadding()
        }
        .infanNavigationBar(title: "내 경매 등록")
    }
}

struct AuctionRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionRegistrationView()
        }
    }
}
