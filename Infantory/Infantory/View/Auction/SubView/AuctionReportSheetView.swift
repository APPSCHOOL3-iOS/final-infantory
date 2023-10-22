//
//  AuctionReportSheetView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/21/23.
//

import SwiftUI
import FirebaseFirestore

struct AuctionReportSheetView: View {
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) var dismiss
    var product: AuctionProduct
    @State private var reportString: String = ""
    @State private var reportCase4: String = ""
    @State private var reportCase: ReportCase = .case1
    @Binding var toastMessage: String
    @Binding var isShowingToastMessage: Bool
    var body: some View {
        VStack(spacing: 15) {
            
            VStack(alignment: .leading) {
                Text("'\(product.productName)'\n경매 상품을 신고하는 이유를 선택해주세요.")
                    .font(.infanHeadlineBold)
                    .foregroundColor(.infanBlack)
                
            }
            .padding(.top)
            
            Divider().padding([.top, .bottom], 10)

                RadioButtonGroups { selected in
                    reportString = selected
                    reportCase4 = ""
                }
                if reportString == ReportCase.case4.rawValue {
                    TextField("신고 사유를 입력해주세요.", text: $reportCase4)
                        .horizontalPadding()
                        .overlay {
                            ToastMessage(content: Text("\(toastMessage)"), isPresented: $isShowingToastMessage)
                    }
                }
            Spacer()
            Button {
                if reportString == ReportCase.case4.rawValue && reportCase4.isEmpty {
                    toastMessage = "사유를 입력해주세요"
                    isShowingToastMessage = true
                    return
                }
                reportApply()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.infanMain)
                    .cornerRadius(8)
                    .overlay {
                        Text("INFANTORY에 보내기")
                            .foregroundColor(.white)
                            .font(.infanHeadline)
                            .padding()
                    }
                    .frame(width: .screenWidth - 40, height: 54)
            }
            
            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.infanLightGray)
                    .cornerRadius(8)
                    .overlay {
                        Text("신고 취소")
                            .foregroundColor(.white)
                            .font(.infanHeadline)
                            .padding()
                    }
                    .frame(width: .screenWidth - 40, height: 54)
            }
        }
        .padding()
        .presentationDetents([.height(CGFloat.screenHeight * 0.55)])
        .presentationDragIndicator(.visible)
    }
    
    func reportApply() {
        let dbRef = Firestore.firestore().collection("Report")
        let report = Report(reportProductType: "AuctionProducts", reportProductID: product.id ?? "", reportReason: reportCase4.isEmpty ? reportString : reportCase4, reportDate: Date(), reporterID: loginStore.currentUser.email)
        do {
            try dbRef.addDocument(from: report)
            toastMessage = "신고가 완료되었습니다"
            isShowingToastMessage = true
            dismiss()
        } catch {
            print("신고 실패.")
        }
    }
}
