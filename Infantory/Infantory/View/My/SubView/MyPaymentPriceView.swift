////
////  PaymentInfo.swift
////  Infantory
////
////  Created by 이희찬 on 2023/09/20.
////
//
//import SwiftUI
//
//struct MyPaymentPriceView: View {
//    let viewTitle: String = "최종 주문정보"
//    @ObservedObject var myPaymentStore: MyPaymentStore
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            
//            Text(viewTitle)
//                .font(.headline)
//                .padding(.horizontal)
//            
//            VStack(alignment: .leading, spacing: 22) {
//                
//                ForEach(PaymentCost.allCases, id: \.rawValue) { item in
//                    if item == .totalPrice {
//                        MyTotalPriceRow(item: item, myPaymentStore: myPaymentStore)
//                    } else {
//                        MyPriceDetailRow(item: item, price: myPaymentStore.auctionProduct?.winningPrice ?? 0)
//                    }
//                    
//                }
//            }
//            
//        }
//    }
//}
//
//struct MyPaymentPriceView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPaymentPriceView(myPaymentStore: MyPaymentStore())
//    }
//}
//
//struct MyTotalPriceRow: View {
//    let item: PaymentCost
//    @ObservedObject var myPaymentStore: MyPaymentStore
//    var body: some View {
//        VStack(alignment: .leading, spacing: 22) {
//            Divider()
//            HStack {
//                Text(PaymentCost.totalPrice.title)
//                    .padding(.horizontal)
//            }
//            HStack {
//                Spacer()
//                Text("\(item.receipt(productPrice: myPaymentStore.myPayments[0].auctionProduct?.winningPrice ?? 0))원")
//                    .foregroundColor(.red)
//                    .font(.headline)
//                    .padding(.horizontal)
//            }
//            Divider()
//        }
//        .background(Color.gray.opacity(0.1))
//    }
//}
//
//struct MyPriceDetailRow: View {
//    let item: PaymentCost
//    @ObservedObject var myPaymentStore: MyPaymentStore
//    var body: some View {
//        HStack {
//            Text(item.title)
//                .foregroundColor(.gray)
//            if item == .commission {
//                Button {
//                    //수수료 안내 액션
//                } label: {
//                    Image(systemName: "questionmark.circle")
//                        .foregroundColor(.gray)
//                }
//            }
//            Spacer()
//            
//            Text("\(item.receipt(productPrice: myPaymentStore.myPayments[0].auctionProduct?.winningPrice ?? 0))원")
//        }
//        .padding(.horizontal)
//    }
//}
