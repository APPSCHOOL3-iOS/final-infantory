//
//  PaymentViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import Foundation
import Firebase

class PaymentViewModel: ObservableObject {
    //받아오고
    @Published var user: User = User.dummyUser
    @Published var product: Productable = AuctionProduct.dummyProduct
    //업로드
    @Published var paymentInfo: PaymentInfo
    
    let database = Firestore.firestore()
    
    init(user: User, product: Productable) {
        paymentInfo = PaymentInfo(
            userId: user.id ?? "",
            product: product.id ?? "",
            address: user.address,
            deliveryRequest: .door,
            deliveryCost: 3000,
            paymentMethod: PaymentMethod.accountTransfer)
    }
    
    func uploadPaymentInfo() {
        let paymentInfoRef = database.collection("paymentInfos")
        let paymentInfoId = UUID().uuidString
        do {
            try paymentInfoRef.document(paymentInfoId).setData(from: paymentInfo) { error in
                // 유저에 업데이트된 결제정보 저장
                if error == nil {
                    self.database.collection("users").document(self.user.id ?? "")
                        .updateData([
                            "paymentInfos": FieldValue.arrayUnion([paymentInfoId])
                        ]) { updateError in
                            if let updateError = updateError {
                                print("DEBUG: Error updating: \(updateError)")
                            } else {
                                print("DEBUG: successfully updated!")
                            }
                        }
                }
            }
        } catch let error {
            print("DEBUG: Error adding paymentInfo: \(error)")
        }
        
    }
    
}
