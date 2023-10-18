//
//  MyPaymentsDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/18.
//

import SwiftUI

struct MyPaymentsDetailView: View {
    var myPaymentStore: MyPaymentStore
    @EnvironmentObject var loginStore: LoginStore
    @Binding var selectedIndex: Int
    var body: some View {
        ScrollView {
            // 상세내역 가운데로 오게하기
            // 이전뷰로 돌아가기 버튼 
            switch myPaymentStore.myPayments[selectedIndex].type {
            case .auction:
                VStack(alignment: .leading, spacing: 13) {
                    Text("상세내역")
                        .font(.infanTitle2)
                    HStack {
                        CachedImage(url: myPaymentStore.myPayments[selectedIndex].auctionProduct?.productImageURLStrings[0] ?? "") { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            case .failure(let error):
                                Image("smallAppIcon")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        VStack(spacing: 10) {
                            Text("\(myPaymentStore.myPayments[selectedIndex].auctionProduct?.influencerNickname ?? "")")
                            Text("\(myPaymentStore.myPayments[selectedIndex].auctionProduct?.productName ?? "")")
                        }
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    Divider()
                    HStack(spacing: 30) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("배송 주소")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanBlack)
                            Text("성함")
                            Text("연락처")
                            Text("주소")
                        }
                        .font(.infanHeadline)
                        .foregroundColor(.infanLightGray)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("")
                            Text("\(loginStore.currentUser.name)")
                            Text("\(loginStore.currentUser.phoneNumber)")
                            Text("\(loginStore.currentUser.address.address) \( loginStore.currentUser.address.addressDetail)")
                        }
                        .foregroundColor(.infanBlack)
                        .font(.infanHeadline)
                    }
                    Divider()
                    HStack {
                        Text("구매가")
                        Spacer()
                        Text("\(myPaymentStore.myPayments[selectedIndex].auctionProduct?.winningPrice ?? 0)원")
                            .foregroundColor(.infanBlack)
                            .font(.infanHeadline)
                    }
                    HStack {
                        Text("수수료")
                            .font(.infanHeadline)
                            .foregroundColor(.infanLightGray)
                        Spacer()
                        Text("0원")
                    }
                    HStack {
                        Text("배송비")
                            .font(.infanHeadline)
                            .foregroundColor(.infanLightGray)
                        Spacer()
                        Text("\(myPaymentStore.myPayments[selectedIndex].deliveryCost)원")
                            .foregroundColor(.infanBlack)
                            .font(.infanHeadline)
                    }
                    VStack {
                        Divider()
                        HStack(alignment: .top) {
                            Text("총 결제금액")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanBlack)
                            Spacer()
                            Text("\((myPaymentStore.myPayments[selectedIndex].auctionProduct?.winningPrice ?? 0) + (myPaymentStore.myPayments[selectedIndex].deliveryCost))원")
                                .foregroundColor(.infanRed)
                                .font(.infanHeadline)
                        }
                        .frame(width: (.screenWidth - 30))
                        .padding(.vertical)
                        Divider()
                    }
                    .frame(width: (.screenWidth - 30))
                    .background(Color.gray.opacity(0.1))
                }
                .horizontalPadding()
            case .apply:
                VStack(spacing: 13) {
                    HStack {
                        Text("구매가")
                        Spacer()
                        Text("\(myPaymentStore.myPayments[selectedIndex].applyProduct?.winningPrice ?? 0)원")
                    }
                    HStack {
                        Text("수수료")
                        Spacer()
                        Text("0원")
                    }
                    HStack {
                        Text("배송비")
                        Spacer()
                        Text("\(myPaymentStore.myPayments[selectedIndex].deliveryCost)원")
                    }
                    Divider()
                    HStack {
                        Text("총 결제금액")
                        Spacer()
                        Text("\((myPaymentStore.myPayments[selectedIndex].applyProduct?.winningPrice ?? 0) + (myPaymentStore.myPayments[selectedIndex].deliveryCost))원")
                    }
                }
                .horizontalPadding()
            }
        }
        .padding(.vertical)
    }
}

struct MyPaymentsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentsDetailView(myPaymentStore: MyPaymentStore(), selectedIndex: .constant(0))
            .environmentObject(LoginStore())
    }
}
