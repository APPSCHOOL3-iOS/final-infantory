//
//  ApplySheetView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/04.
//

import SwiftUI

struct ApplySheetView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    //    @State private var selection: Int = 0
    @State private var tempCount: Int = 0
    @State private var applyTicketCount: String = "0"
    @State private var isShowingAlert: Bool = false
    @State private var toastMessage: String = ""
    @State private var isShowingToastMessage: Bool = false
    
    @Binding var isShowingApplySheet: Bool
    
    var body: some View {
        VStack {
            ApplyMyTicketView()
            
            HStack {
                
                Text("사용할 응모권 갯수")
                
                Spacer()
                
                Button {
                    if 1 >= Int(applyTicketCount) ?? 0 {
                        applyTicketCount = "1"
                    } else {
                        tempCount = (Int(applyTicketCount) ?? 0) - 1
                        applyTicketCount = String(tempCount)
                    }
                } label: {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.infanMain)
                }
                
                TextField("", text: $applyTicketCount)
                    .font(.infanTitle2)
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
                    .onChange(of: applyTicketCount) { newValue in
                        if let intValue = Int(newValue) {
                            if intValue > loginStore.totalApplyTicketCount {
                                applyTicketCount = String(loginStore.totalApplyTicketCount)
                            } else if intValue < 1 {
                                applyTicketCount = "1"
                            }
                        } else {
                            // 정수로 변환할 수 없는 경우 기본값 설정
                            applyTicketCount = ""
                        }
                    }
                
                Button {
                    if Int(applyTicketCount) ?? 0 >= loginStore.totalApplyTicketCount {
                        applyTicketCount = String(loginStore.totalApplyTicketCount)
                    } else {
                        tempCount = (Int(applyTicketCount) ?? 0) + 1
                        applyTicketCount = String(tempCount)
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.infanMain)
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .fill(Color.infanDarkGray))
            .infanHorizontalPadding()
            .frame(width: CGFloat.screenWidth, height: 80)
            
            HStack {
                Button {
                    isShowingApplySheet = false
                } label: {
                    Text("닫기")
                        .padding()
                        .font(.infanTitle2)
                        .foregroundColor(.white)
                }
                .frame(width: .screenWidth / 2 - 20)
                .background(Color.infanLightGray)
                .cornerRadius(8)
                
                Button {
                    if applyTicketCount == "0" {
                        toastMessage = "최소 1장 이상 응모해주세요."
                        isShowingToastMessage = true
                    } else {
                        isShowingAlert = true
                    }
                } label: {
                    Text("응모하기")
                        .padding()
                        .font(.infanTitle2)
                        .foregroundColor(.white)
                }
                .frame(width: .screenWidth / 2 - 20)
                .background(Color.infanMain)
                .cornerRadius(8)
            }
            .padding()
            
            //            Picker("응모권 갯수", selection: $selection) {
            //                ForEach(1 ..< loginStore.totalApplyTicketCount + 1, id: \.self) { count in
            //                    Text("\(count)")
            //                }
            //            }
            //            .pickerStyle(.wheel)
            // 몇장 응모할건지
            // 닫기
            // 응모버튼 -> 응모하면 응모됐다고 알러트
            // 응모되면 응모하기 버튼 응모취소하기? 아니면 그냥 disable?
        }
        .overlay(
            ToastMessage(content: Text("\(toastMessage)"), isPresented: $isShowingToastMessage)
        )
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("응모하기"),
                  message: Text("\(applyTicketCount)장 응모하시겠습니까?"),
                  primaryButton: .cancel(Text("취소")),
                  secondaryButton: .default(Text("응모하기")) {
                isShowingApplySheet = false
            })
        }
    }
}

struct ApplySheetView_Previews: PreviewProvider {
    static var previews: some View {
        ApplySheetView(isShowingApplySheet: .constant(true))
            .environmentObject(LoginStore())
    }
}
