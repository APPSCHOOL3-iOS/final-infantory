//
//  ApplyAddButtonView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

struct ApplyAddButtonView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @Binding var isShowingApplySheet: Bool
    @Binding var isShowingLoginSheet: Bool
    @Binding var isShowingPaymentSheet: Bool
    var product: ApplyProduct
    @State private var isShowingWinning: Bool = false
    var body: some View {
        VStack {
            if product.applyFilter == .inProgress {
                Button {
                    if loginStore.userUid.isEmpty {
                        isShowingLoginSheet = true
                    } else {
                        isShowingApplySheet.toggle()
                    }
                } label: {
                    Text("응모하기")
                        .font(.infanHeadlineBold)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.infanMain)
                                .frame(width: CGFloat.screenWidth - 40, height: 54)
                        )
                }
            } else if product.applyFilter == .planned {
                Text("응모 시작 전입니다.")
                    .font(.infanHeadlineBold)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.infanGray)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            } else if product.applyCloseFilter == .afterRaffle {
                if product.winningUserID == loginStore.currentUser.email {
                    Button {
                        isShowingPaymentSheet = true
                    } label: {
                        Text("결제하기")
                            .font(.infanHeadlineBold)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.infanMain)
                                    .frame(width: CGFloat.screenWidth - 40, height: 54)
                            )
                    }
                } else {
                    Text("이미 종료된 응모입니다.")
                        .font(.infanHeadlineBold)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.infanGray)
                                .frame(width: CGFloat.screenWidth - 40, height: 54)
                        )
                }
            } else if product.applyCloseFilter == .beforeRaffle {
                Text("추첨 중인 응모입니다.")
                    .font(.infanHeadlineBold)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.infanGray)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            } else {
                Text("이미 종료된 응모입니다.")
                    .font(.infanHeadlineBold)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.infanGray)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            }
        }
        .offset(y: -20)
        .alert(isPresented: $isShowingWinning) {
            Alert(title: Text("🎉응모 당첨!!🎉"),
                  message: Text("응모에 당첨되셨습니다. 3일 이내 미결제시 당첨이 취소됩니다."),
                  primaryButton: .default(Text("취소")),
                  secondaryButton: .default(Text("확인")))
        }
        .onAppear {
            if product.winningUserID == loginStore.currentUser.email {
                isShowingWinning = true
            } else {
                isShowingWinning = false
            }
        }
    }
}

struct ApplyAddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyAddButtonView(isShowingApplySheet: .constant(true), 
                           isShowingLoginSheet: .constant(true),
                           isShowingPaymentSheet: .constant(false),
                           product:
                            ApplyProduct(productName: "",
                                         productImageURLStrings: [""],
                                         description: "",
                                         influencerID: "",
                                         influencerNickname: "볼빨간사춘기",
                                         startDate: Date(), 
                                         endDate: Date(), 
                                         registerDate: Date(),
                                         applyUserIDs: [""]))
        .environmentObject(LoginStore())
    }
}
