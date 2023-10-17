//
//  PaymentViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import Foundation
import Firebase

struct PaymentStore {
    var user: User
    var product: Productable
    
    let database = Firestore.firestore()
    
    init(user: User, product: Productable) {
        self.user =  user
        self.product = product
    }
    
    func uploadPaymentInfo(paymentInfo: PaymentInfo) {
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
                                #if DEBUG
                                print("DEBUG: Error updating: \(updateError)")
                                #endif
                            } else {
                                #if DEBUG
                                print("DEBUG: successfully updated!")
                                #endif
                            }
                        }
                }
            }
        } catch let error {
            #if DEBUG
            print("DEBUG: Error adding paymentInfo: \(error)")
            #endif
        }
        
    }
    
}
