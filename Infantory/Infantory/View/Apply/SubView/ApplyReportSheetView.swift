//
//  ReportSheetView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/20/23.
//

import SwiftUI
enum ReportCase: String, CaseIterable {
    case case1 = "거래 금지 물품이에요"
    case case2 = "상품 사진이 부적절해요"
    case case3 = "상품 설명이 부적절해요"
}
struct ApplyReportSheetView: View {
    
    var product: ApplyProduct
    @State var reportString: String = ""
    var body: some View {
        VStack(spacing: 15) {
            Text("응모 신고")
                .foregroundColor(.infanBlack)
                .padding(.top, 10)
            
            Divider().padding([.top, .bottom], 10)
            
            VStack(alignment: .leading) {
                Text("'\(product.productName)'\n응모 상품을 신고하는 이유를 선택해주세요.")
                    .font(.infanHeadlineBold)
                    .foregroundColor(.infanBlack)
                    
            }
            
            Divider().padding([.top, .bottom], 10)
            
            VStack(alignment: .leading) {
                ForEach(ReportCase.allCases, id: \.self) { report in
                    Button {
                        reportString = report.rawValue
                    } label: {
                        Text("\(report.rawValue)")
                            .font(.infanFootnote)
                    }
                    Divider().padding([.top, .bottom], 10)
                    
                }
                HStack {
                    Text("기타 : ")
                        .font(.infanFootnote)
                        .foregroundColor(.infanMain)
                    TextField("신고 사유를 입력해주세요.", text: $reportString)
                        .font(.infanFootnote)
                }
            }
            
            Button {
               
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
            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
