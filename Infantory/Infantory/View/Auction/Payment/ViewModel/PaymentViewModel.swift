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
    id: "1",
    isInfluencer: .user,
    profileImageURLString: "https://example.com/profile/1.jpg",
    name: "John Doe",
    phoneNumber: "123-456-7890",
    email: "john@example.com",
    birthDate: "1990-01-01",
    loginType: .kakao,
    address: Address(fullAddress: "123 Main Street, City"),
    paymentInfos: [
        PaymentInfo(
            product: "Product 1",
            deliveryRequest: "Please deliver to my home.",
            price: 50,
            commission: 5,
            deliveryCost: 10,
            paymentMethod: .card
        ),
        PaymentInfo(
            product: "Product 2",
            deliveryRequest: "Leave at the front desk.",
            price: 30,
            commission: 3,
            deliveryCost: 5,
            paymentMethod: .accountTransfer
        )
    ],
    applyTicket: [
        ApplyTicket(
            id: "ticket1",
            userId: "john@example.com",
            date: Date(),
            ticketGetAndUse: "Ticket 123",
            count: 2
        ),
        ApplyTicket(
            id: "ticket2",
            userId: "john@example.com",
            date: Date(),
            ticketGetAndUse: "Ticket 456",
            count: 1
        )
    ],
    influencerIntroduce: nil
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
    winningPrice: 0 // 낙찰가는 아직 결정되지 않았으므로 0으로 설정
)
