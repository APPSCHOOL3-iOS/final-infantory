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
    @Published var product: Productable = auctionProduct
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
    
    func uploadPaymentInfo() { // 이거 일단 주석처리 함
        
    }
    
    var totalPrice: Int {
        let winningPrice = product.winningPrice ?? 0
        return winningPrice + winningPrice / 10 + 3000
        
    }
    
}

let auctionProduct = AuctionProduct(
    id: "1",
    productName: "Example Product",
    productImageURLStrings: ["https://dimg.donga.com/wps/NEWS/IMAGE/2021/12/11/110733453.1.jpg"],
    description: "This is an example product for auction.",
    influencerID: "상필갓",
    winningUserID: nil, // 낙찰자가 아직 없는 경우 nil로 설정
    startDate: Date(), // 현재 날짜로 설정
    endDate: Date().addingTimeInterval(7 * 24 * 60 * 60), // 현재 날짜로부터 7일 후로 설정
    minPrice: 100, // 시작가
    winningPrice: 100000 // 낙찰가는 아직 결정되지 않았으므로 0으로 설정
)
