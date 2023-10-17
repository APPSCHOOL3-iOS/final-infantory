//
//  orderReceiptView.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import SwiftUI
import FirebaseFirestore

struct PaymentReceiptView: View {
    let paymentStore: PaymentStore
    let paymentInfo: PaymentInfo
    
    @Binding var isShowingPaymentSheet: Bool
    
    var body: some View {
        VStack {
            Text("주문이 완료되었습니다!")
                .font(.headline)
                .frame(width: CGFloat.screenWidth - 10, height: 50, alignment: .leading)
                .background(.gray.opacity(0.2))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("주문자")
                            .frame(width: 50, alignment: .leading)
                        Text(paymentStore.user.name)
                    }
                    
                    HStack {
                        Text("주소")
                            .frame(width: 50, alignment: .leading)
                        Text(paymentStore.user.address.address)
                    }
                }
                .padding()
                
                PaymentPriceView(price: paymentStore.product.winningPrice ?? 0)
            }
            Spacer()
            
            Button {
                isShowingPaymentSheet = false
                Task {
                    updateIsPaid()
                }
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: CGFloat.screenWidth - 30, height: 60)
                    .foregroundColor(.infanMain)
                    .overlay(
                        Text("완료")
                            .foregroundColor(.white)
                    )
                    .padding()
                
            }
        }
        .navigationBar(title: "구매완료")
        .onAppear {
            paymentStore.uploadPaymentInfo(paymentInfo: paymentInfo)
        }
    }
    
    func updateIsPaid() {
        let firestore = Firestore.firestore()
        firestore.collection("AuctionProducts").document(paymentStore.product.id ?? "").updateData([
                    "isPaid": false
                ]) { error in
                    if let error = error {
                        print("updating Error: \(error)")
                    } else {
                        print("successfully updated!")
                    }
                }
    }
}

struct ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentReceiptView(paymentStore: PaymentStore(user: User.dummyUser,
                                                       product: AuctionProduct.dummyProduct),
                               paymentInfo: PaymentInfo(userId: "",
                                                        address: Address.init(address: "",
                                                                              zonecode: "",
                                                                              addressDetail: ""),
                                                        deliveryRequest: .door,
                                                        deliveryCost: 3000,
                                                        paymentMethod: .accountTransfer), 
                               isShowingPaymentSheet: .constant(true))
        }
    }
}
