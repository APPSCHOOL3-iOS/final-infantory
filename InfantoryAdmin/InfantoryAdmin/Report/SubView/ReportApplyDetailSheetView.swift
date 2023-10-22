//
//  ReportApplyDetailSheetView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import SwiftUI

struct ReportApplyDetailSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var reportStore: ReportStore
    var product: ApplyProduct
    
    var detailProduct: [GroupedReport] {
        let filteredproduct = reportStore.groupApplies.filter { apply in
            apply.reportProductID == product.id
        }
        return filteredproduct
    }
    @State private var isShowAlert: Bool = false
    var body: some View {
        VStack {
            List {
                ForEach(detailProduct) { detail in
                    ForEach(detail.reporters.indices, id: \.self) { reporter in
                        VStack(alignment: .leading, spacing: 10) {
                            Text("신고자 ID : \(detail.reporters[reporter])")
                            Text("신고사유 : \(detail.reasons[reporter])")
                            Text("신고일 : \(detail.dates[reporter])")
                        }
                    }
                }
            }
            Button {
                isShowAlert = true
            } label: {
                Text("게시물 삭제")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("게시물 삭제"),
                  message: Text("게시물을 삭제하시겠습니까?"),
                  primaryButton: .default(Text("취소")),
                  secondaryButton: .destructive(Text("삭제")) {
                reportStore.deleteProduct(productID: product.id ?? "", productType: "ApplyProducts")
                dismiss()
            })
        }
    }
}

