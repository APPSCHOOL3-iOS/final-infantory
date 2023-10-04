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
    @State private var applyTicketCount: String = ""
    
    var body: some View {
        VStack {
            ApplyMyTicketView()
            
            Text("응모권")
            
            HStack {
                Button {
                    if 1 >= Int(applyTicketCount) ?? 0 {
                        applyTicketCount = "1"
                    } else {
                        tempCount = (Int(applyTicketCount) ?? 0) - 1
                        applyTicketCount = String(tempCount)
                    }
                } label: {
                    Image(systemName: "minus")
                }
                
                TextField("", text: $applyTicketCount)
                    .font(.infanTitle2)
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
//                    .onChange(of: applyTicketCount) { newValue in
//                        if Int(newValue) ?? 0 >= loginStore.totalApplyTicketCount {
//                            applyTicketCount = String(loginStore.totalApplyTicketCount)
//                        } else if 1 >= Int(newValue) ?? 0 {
//                            applyTicketCount = "1"
//                        }
//                    }
                
                Button {
                    if Int(applyTicketCount) ?? 0 >= loginStore.totalApplyTicketCount {
                        applyTicketCount = String(loginStore.totalApplyTicketCount)
                    } else {
                        tempCount = (Int(applyTicketCount) ?? 0) + 1
                        applyTicketCount = String(tempCount)
                    }
                } label: {
                    Image(systemName: "plus")
                }

            }
            
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
    }
}

struct ApplySheetView_Previews: PreviewProvider {
    static var previews: some View {
        ApplySheetView()
            .environmentObject(LoginStore())
    }
}
