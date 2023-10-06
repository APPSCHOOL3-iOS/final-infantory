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
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isShowAlert: Bool = false
    @State private var auctionProductSelectedImages: [UIImage] = []
    @State private var auctionProductSelectedImageNames: [String] = []
    @State private var auctionCustumeSelectedImages: [UIImage] = []
    @State private var auctionCustumeSelectedImageNames: [String] = []
    @State private var auctionStartingPrice: String = ""
    @State private var auctionStartingPriceInt: Int? = nil
    @State private var auctionisErrorVisible = false
    @State private var auctionEndDate = Date().addingTimeInterval(7 * 24 * 60 * 60)
    @State private var auctionStartDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    @State private var pushButtonColor: Bool = false
    @State private var selectedDate = Date()
    @State private var resultText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
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
                    
                    // TODO: 경매시작, 종료일도 받아야함 + 시작일은 TextField가 아닌 Date로 받아야 하고, 시작가는 Int 키보드로 받기.
                    TextField("시작가", text: $auctionStartingPrice)
                        .keyboardType(.numberPad)
                        .onChange(of: auctionStartingPrice, perform: { newValue in
                            if let intValue = Int(newValue) {
                                auctionStartingPriceInt = intValue
                                auctionisErrorVisible = false
                            } else {
                                auctionisErrorVisible = true
                            }
                        })
                    Divider()
                    
                    if auctionisErrorVisible {
                        Text("숫자를 입력해 주세요.")
                            .foregroundColor(.red)
                    } else if let price = auctionStartingPriceInt {
                        Text("\(price)원")
                        
                    }
                    DatePicker("경매시작일", selection: $selectedDate, displayedComponents: [.hourAndMinute, .date])
                        .padding(.vertical)
                    HStack {
                        Button(action: {
                                self.calculateDateOffset(days: 3)
                        }) {
                            Text("3일")
                                .frame(width: 50)
                                .padding()
                                .foregroundColor(.infanDarkGray)
                                .background(pushButtonColor ? .purple : .gray)
                                .buttonStyle(.borderedProminent)
                        }
                        
                        Button(action: {
                            self.calculateDateOffset(days: 5)
                        }) {
                            Text("5일")
                                .frame(width: 50)
                                .padding()
                                .foregroundColor(.infanDarkGray)
                                .background(Capsule().strokeBorder())
                        }
                        
                        Button(action: {
                            self.calculateDateOffset(days: 7)
                        }) {
                            Text("7일")
                                .frame(width: 50)
                                .padding()
                                .foregroundColor(.infanDarkGray)
                                .background(Capsule().strokeBorder())
                        }
                        Button(action: {
                            self.calculateDateOffset(days: 10)
                        }) {
                            Text("10일")
                                .frame(width: 50)
                                .padding()
                                .foregroundColor(.infanDarkGray)
                                .background(Capsule().strokeBorder())
                        }
                    }
                    Text(resultText)
                    
                    Divider()
                    
                    Spacer()
                    
                    InfanMainButton(text: "등록하기") {
                        if title.isEmpty {
                            showAlert = true
                            alertMessage = "제목을 입력해주세요."
                        } else if itemDescription.isEmpty {
                            showAlert = true
                            alertMessage = "소개를 입력해주세요."
                        } else if auctionStartingPrice.isEmpty {
                            showAlert = true
                            alertMessage = "시작가를 입력해주세요."
                        } else {
                            let product = registViewModel.makeAuctionModel(title: title,
                                                                           apply: apply,
                                                                           itemDescription: itemDescription, startingPrice: auctionStartingPrice,
                                                                           
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
    func calculateDateOffset(days: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "YYYY년 M월 d일 a hh시 mm분"
            formatter.locale = Locale(identifier:"ko_KR")
            resultText = "\(days)일 후: \(formatter.string(from: newDate))"
        }
    }
}

struct AuctionRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionRegistrationView()
        }
    }
}
