//
//  PaymentViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var user: User = dummyUser
    @Published var product: Productable = auctionProduct
}

let dummyUser = User(
    id: "123456",
    isInfluencer: .user,
    profileImageURLString: "https://example.com/profile.jpg",
    name: "상필",
    phoneNumber: "555-555-5555",
    email: "sangpil0101@example.com",
    loginType: .kakao,
    address: Address(fullAddress: "부산 남구 용소로 45 행복기숙사B0506"),
    paymentInfos: [
        PaymentInfo(
            product: "Example Product",
            deliveryRequest: "Please deliver as soon as possible.",
            price: 100,
            commission: 10,
            deliveryCost: 5,
            paymentMethod: .card
        ),
    ],
    paymentMethod: .card
)

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
    maxPrice: 500, // 최고가
    winningPrice: 100000
)
