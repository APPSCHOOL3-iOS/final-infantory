//
//  ApplyLotteryView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

struct ApplyLotteryView: View {
    @StateObject private var applyLotteryStore = ApplyLotteryStore()
    @State private var isShowAlert: Bool = false
    @State private var closeCategory: ApplyCloseFilter = .beforeRaffle
    @State private var isShowToastMessage: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                ApplyTabBarView(applyLotteryStore: applyLotteryStore, closeCategory: $closeCategory)
                TabView(selection: $closeCategory) {
                    ForEach(ApplyCloseFilter.allCases, id: \.self) { category in
                        switch closeCategory {
                        case .beforeRaffle:
                            ScrollView {
                                VStack {
                                    if applyLotteryStore.applyBeforeLotteries.isEmpty {
                                        Spacer()
                                        Text("추첨 할 상품이 없습니다.")
                                        Spacer()
                                    } else {
                                        HStack {
                                            Spacer()
                                            
                                            Button {
                                                isShowAlert = true
                                            } label: {
                                                Text("일괄추첨")
                                            }
                                        }
                                        .padding()
                                        ForEach(applyLotteryStore.applyBeforeLotteries) { product in
                                            ApplyListCellView(applyViewModel: applyLotteryStore, product: product)
                                        }
                                    }
                                }
                            }.tag(category)
                        case .afterRaffle:
                            ScrollView {
                                ForEach(applyLotteryStore.applyAfterLotteries) { product in
                                    ApplyListCellView(applyViewModel: applyLotteryStore, product: product)
                                }
                            }.tag(category)
                        }
                    }
                }
                ToastMessageView(content: Text("추첨이 완료되었습니다."), isPresented: $isShowToastMessage)
            }
        }
        .refreshable {
            try? await applyLotteryStore.fetchApplyProduct()
        }
        .task {
            try? await applyLotteryStore.fetchApplyProduct()
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("일괄추첨"),
                  message: Text("일괄추첨 하시겠습니까?"),
                  primaryButton: .default(Text("취소")),
                  secondaryButton: .default(Text("추첨하기")) {
                applyLotteryStore.lotteryApply()
                isShowToastMessage = true
            })
        }
    }
}

struct ApplyLotteryView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyLotteryView()
    }
}
