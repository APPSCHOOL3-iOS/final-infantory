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
            product: product.id,
            address: user.address,
            deliveryRequest: .door,
            deliveryCost: 3000,
            paymentMethod: PaymentMethod.accountTransfer)
    }
    
    func uploadPaymentInfo() {
        let paymentInfoRef = database.collection("paymentInfos")
        
        do {
            try paymentInfoRef.addDocument(from: paymentInfo)
        } catch let error {
            print("Error adding payment info: \(error)")
        }
        
        //유저에 paymentInfo Id 저장하기.
    }
    
    var totalPrice: Int {
        let winningPrice = product.winningPrice ?? 0
        return winningPrice + winningPrice / 10 + 3000
    }
    
}
