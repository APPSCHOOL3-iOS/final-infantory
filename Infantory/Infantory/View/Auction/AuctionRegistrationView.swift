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
    @StateObject var auctionProductViewModel = AuctionProductViewModel()
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
    @State private var selectedDate = Date()
    @State private var resultText = ""
    @State private var dateList = ["3", "5", "7", "10"]
    @State private var selectedDateString: String = "0"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack {
                    ProductImagePickerView(selectedImages: $auctionProductSelectedImages, selectedImageNames: $auctionProductSelectedImageNames)
                    HStack(alignment: .top) {
                        DressedUpImageView(selectedImages: $auctionCustumeSelectedImages, selectedImageNames: $auctionCustumeSelectedImageNames)
                    }
                }
                
                VStack(spacing: 16) {
                    
                    UnderlineTextField(textFieldTitle: "애장품",
                                       placeholder: "애장품 이름을 입력해주세요.",
                                       text: $title)
                    
                    RoundedTextEditor(textFieldTitle: "소개",
                                      placeHolder: "애장품을 소개해주세요.",
                                      text: $itemDescription)
                    VStack(alignment: .leading) {
                        UnderlineTextField(textFieldTitle: "시작가",
                                           placeholder: "시작가를 입력해주세요.",
                                           text: $auctionStartingPrice)
                        .keyboardType(.numberPad)
                        .onChange(of: auctionStartingPrice, perform: { newValue in
                            if let intValue = Int(newValue) {
                                auctionStartingPriceInt = intValue
                                auctionisErrorVisible = false
                            } else {
                                auctionisErrorVisible = true
                            }
                        })
                        
                        if auctionisErrorVisible {
                            Text("숫자를 입력해 주세요.")
                                .foregroundColor(.red)
                        } else if let price = auctionStartingPriceInt {
                            Text("시작가: \(price)원 입니다.")
                                .font(.infanHeadlineBold)
                        }
                    }
                    DatePicker("경매시작일", selection: $selectedDate, displayedComponents: [.hourAndMinute, .date])
                        .font(.infanHeadlineBold)
                        .padding(.vertical)
                    
                    HStack {
                        Text("경매종료일")
                            .font(.infanHeadlineBold)
                        Spacer()
                        Text("\(resultText)")
                            .font(.infanBody)
                    }
                    
                    HStack {
                        ForEach(dateList, id: \.self) { date in
                            dateSelectButton(date: date)
                        }
                    }
                    
                    MainColorButton(text: "등록하기") {
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
                                                                           itemDescription: itemDescription,
                                                                           startingPrice: auctionStartingPrice,
                                                                           imageStrings: auctionProductSelectedImageNames + auctionCustumeSelectedImageNames,
                                                                           startDate: auctionStartDate,
                                                                           endDate: auctionEndDate,
                                                                           user: loginStore.currentUser)
                            Task {
                                try await registViewModel.addAuctionProduct(auctionProduct: product, images: auctionProductSelectedImages + auctionCustumeSelectedImages, completion: {_ in dismiss()
                                })
                            }
                        }
                    }
                    .padding(.vertical, 30)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }
            }
            .horizontalPadding()
        }
        .navigationBar(title: "내 경매 등록")
    }
    func calculateDateOffset(days: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) {
            let newDateText = InfanDateFormatter.shared.dateTimeString(from: newDate)
            resultText = newDateText
            self.auctionEndDate = newDate
        }
    }
}
extension AuctionRegistrationView {
    func dateSelectButton(date: String) -> some View {
        
        Button {
            self.calculateDateOffset(days: Int(date) ?? 3)
            selectedDateString = date
        } label: {
            if date == selectedDateString {
                Rectangle()
                    .stroke(lineWidth: 1)
                    .background(Color.infanMain)
                    .cornerRadius(10)
                //                    .fill(Color.infanMain)
                    .opacity(0.3)
                    .overlay {
                        Text("\(date)일")
                            .font(.infanHeadline)
                            .foregroundColor(.infanMain)
                            .padding()
                    }
                    .frame(width: (.screenWidth-70)/4, height: 54)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .cornerRadius(10)
                    .overlay {
                        Text("\(date)일")
                            .font(.infanHeadline)
                            .padding()
                    }
                    .frame(width: (.screenWidth-70)/4, height: 54)
            }
        }
        .buttonStyle(.plain)
        .padding(.bottom, 8)
    }
}

struct AuctionRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionRegistrationView()
        }
    }
}
