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
                Button {
                    selectedIndex = index
                    print("\(selectedIndex)")
                    showingModal.toggle()
                } label: {
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
                                    case .failure(let error):
                                        Image("smallAppIcon")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                VStack(spacing: 10) {
                                    Text("\(myPaymentStore.myPayments[index].auctionProduct?.influencerNickname ?? "")")
                                    Text("\(myPaymentStore.myPayments[index].auctionProduct?.productName ?? "")")
                                }
                                Spacer()
                                Text("\((myPaymentStore.myPayments[index].auctionProduct?.winningPrice ?? 0) + (myPaymentStore.myPayments[index].deliveryCost))원")
                            }
                            Spacer()
                            Divider()
                        }
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
                                    Text("\(myPaymentStore.myPayments[index].applyProduct?.influencerNickname ?? "")")
                                    Text("\(myPaymentStore.myPayments[index].applyProduct?.productName ?? "")")
                                }
                                Spacer()
                                Text("\(myPaymentStore.myPayments[index].applyProduct?.winningPrice ?? 0)원")
//                                Button {
//                                    showingModal.toggle()
//                                } label: {
//                                    Image(systemName: showingModal ? "chevron.down" : "chevron.up")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 10, height: 13)
//                                        .foregroundColor(.black)
//                                        .padding()
//                                }
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
