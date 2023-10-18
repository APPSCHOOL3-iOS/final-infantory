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
    
    var body: some View {
        ScrollView {
            ForEach(myPaymentStore.myPayments) { payment in
                switch payment.type {
                case .auction:
                    VStack {
                        HStack {
                            CachedImage(url: payment.auctionProduct?.influencerProfile ?? "") { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 80, height: 80)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 80, height: 80)
                                    
                                case .failure(let error):
                                    Image("smallAppIcon")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 80, height: 80)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            VStack(spacing: 10) {
                                Text("\(payment.auctionProduct?.influencerNickname ?? "")")
                                Text("\(payment.auctionProduct?.productName ?? "")")
                            }
                            Spacer()
                            Text("\(payment.auctionProduct?.winningPrice ?? 0)원")
                            Button {
                                showingModal.toggle()
                            } label: {
                                Image(systemName: showingModal ? "chevron.down" : "chevron.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 10, height: 13)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        }
                        Spacer()
                        Divider()
                        if showingModal {
                            MyPaymentsDetailView(payment: payment)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                                .background(Color.white)
                        }
                    }
                    .padding(.vertical)
                    .horizontalPadding()

                case .apply:
                    VStack {
                        HStack {
                            CachedImage(url: payment.applyProduct?.influencerProfile ?? "") { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 80, height: 80)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 80, height: 80)
                                    
                                case .failure(let error):
                                    Image("smallAppIcon")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 80, height: 80)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            VStack(spacing: 10) {
                                Text("\(payment.applyProduct?.influencerNickname ?? "")")
                                Text("\(payment.applyProduct?.productName ?? "")")
                            }
                            Spacer()
                            Text("\(payment.applyProduct?.winningPrice ?? 0)원")
                            Button {
                                showingModal.toggle()
                            } label: {
                                Image(systemName: showingModal ? "chevron.down" : "chevron.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 10, height: 13)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        }
                        Spacer()
                        Divider()
                        if showingModal {
                            MyPaymentsDetailView(payment: payment)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                                .background(Color.white)
                        }
                    }
                    .padding(.vertical)
                    .horizontalPadding()

                }
            }
        }
        .navigationBar(title: "결제정보")
    }
}

struct MyPaymentsListView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentsListView(myPaymentStore: MyPaymentStore())
    }
}
