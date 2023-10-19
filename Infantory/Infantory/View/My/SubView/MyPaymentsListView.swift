//
//  PaymentDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/17.
//

import SwiftUI

struct MyPaymentsListView: View {
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    @ObservedObject var myPaymentStore: MyPaymentStore
    
    @State private var showingModal: Bool = false
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ScrollView {
            ForEach(myPaymentStore.myPayments.indices, id: \.self) { index in
                    switch myPaymentStore.myPayments[index].type {
                    case .auction:
                        VStack {
                            HStack {
                                CachedImage(url: myPaymentStore.myPayments[index].auctionProduct?.productImageURLStrings[0] ?? "") { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(5)
                                    case .failure:
                                        Image("smallAppIcon")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(myPaymentStore.myPayments[index].auctionProduct?.influencerNickname ?? "")")
                                        .font(.infanHeadline)
                                        .foregroundColor(.infanBlack)
                                    Text("\(myPaymentStore.myPayments[index].auctionProduct?.productName ?? "")")
                                        .font(.infanHeadline)
                                        .foregroundColor(.infanBlack)
                                }
                                Spacer()
                                VStack(spacing: 10) {
                                    Text("\((myPaymentStore.myPayments[index].auctionProduct?.winningPrice ?? 0) + (myPaymentStore.myPayments[index].deliveryCost))원")
                                        .font(.infanHeadline)
                                        .foregroundColor(.infanBlack)
                                    Button {
                                        selectedIndex = index
                                        showingModal.toggle()
                                    } label: {
                                        Text("주문상세")
                                            .font(.infanFootnote)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.gray, lineWidth: 1)
                                                    .frame(width: 70, height: 25)
                                            )
                                    }
                                }
                                .offset(y: 5)
                            }
                            Spacer()
                            Divider()
                        }
                        .horizontalPadding()
                    case .apply:
                        VStack {
                            HStack {
                                CachedImage(url: myPaymentStore.myPayments[index].applyProduct?.influencerProfile ?? "") { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 80, height: 80)
                                        
                                    case .failure:
                                        Image("smallAppIcon")
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 80, height: 80)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                VStack(spacing: 10) {
                                    Text("\(myPaymentStore.myPayments[index].applyProduct?.influencerNickname ?? "")")
                                    Text("\(myPaymentStore.myPayments[index].applyProduct?.productName ?? "")")
                                }
                                Spacer()
                                Text("\(myPaymentStore.myPayments[index].applyProduct?.winningPrice ?? 0)원")
                            }
                            Spacer()
                            Divider()
                        }
                    }
            }
            .sheet(isPresented: $showingModal, content: {
                MyPaymentsDetailView(myPaymentStore: myPaymentStore, selectedIndex: $selectedIndex)
            })
        }
        .onAppear {
            
        }
        .navigationBar(title: "결제정보")
    }
}

struct MyPaymentsListView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentsListView(myPaymentStore: MyPaymentStore())
    }
}
