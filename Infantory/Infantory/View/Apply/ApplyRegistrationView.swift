//
//  ApplyRegistrationView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyRegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var applyViewModel = ApplyProductViewModel()
    @State private var title: String = ""
    @State private var apply: String = ""
    @State private var itemDescription: String = ""
    @State private var winningPrice: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isShowAlert: Bool = false
    @State private var productSelectedImages: [UIImage] = []
    @State private var productSelectedImageNames: [String] = []
    @State private var custumeSelectedImages: [UIImage] = []
    @State private var custumeSelectedImageNames: [String] = []
    @State private var applyStartingPrice: String = ""
    @State private var applyEndDate = Date().addingTimeInterval(7 * 24 * 60 * 60)
    @State private var applyStartingPriceInt: Int? = nil
    @State private var applyisErrorVisible = false
    @State private var applyStartDate = Date()
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
            VStack(spacing: 15) {
                HStack {
                    // 네비게이션링크를 사용하면 백버튼이 생성됨
                    //                    Image(systemName: "xmark")
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(width: 20, height: 20)
                    Spacer()
                    Text("내 응모 등록")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("상품 사진")
                        .font(.system(size: 17))
                        .bold()
                    ApplyImagePickerView(selectedImages: $productSelectedImages, selectedImageNames: $productSelectedImageNames)
                }
                .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text("착장 사진")
                        .font(.system(size: 17))
                        .bold()
                    ApplyImagePickerView(selectedImages: $custumeSelectedImages, selectedImageNames: $custumeSelectedImageNames)
                }
                .padding(.leading)
                
                VStack(spacing: 16) {
                    InfanTextField(textFieldTitle: "애장품",
                                   placeholder: "애장품 이름을 입력해주세요.",
                                   text: $title)
                    
                    InfanTextEditor(textFieldTitle: "소개",
                                    placeHolder: "애장품을 소개해주세요.",
                                    text: $itemDescription)
                    
                    Divider()
                    DatePicker("경매시작일", selection: $selectedDate, displayedComponents: [.hourAndMinute, .date])
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
                    
                    Divider()
                    Spacer()
                    InfanMainButton(text: "등록하기") {
                        if title.isEmpty {
                            showAlert = true
                            alertMessage = "제목을 입력해주세요."
                        } else if itemDescription.isEmpty {
                            showAlert = true
                            alertMessage = "소개를 입력해주세요."
                        } else {
                            Task {
                                try await applyViewModel.createAuctionProduct(title: title, apply: apply, itemDescription: itemDescription, winningPrice: applyStartingPrice)
                                dismiss()
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }
            }
            .infanHorizontalPadding()
        }
        .infanNavigationBar(title: "내 응모 등록")
    }
    func calculateDateOffset(days: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) {
            let newDateText = InfanDateFormatter.shared.dateTimeString(from: newDate)
            resultText = newDateText
        }
    }
}
extension ApplyRegistrationView {
    func dateSelectButton(date: String) -> some View {
        
        Button {
            self.calculateDateOffset(days: Int(date) ?? 3)
            selectedDateString = date
        } label: {
            if date == selectedDateString {
                Rectangle()
                    .stroke(lineWidth: 1)
                    .background(Color.infanMain)
                    .cornerRadius(8)
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
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .cornerRadius(8)
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


struct ApplyRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyRegistrationView()
    }
}
