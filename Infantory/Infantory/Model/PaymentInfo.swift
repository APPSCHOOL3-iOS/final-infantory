//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/21.
//

import Foundation
import FirebaseFirestoreSwift

struct PaymentInfo: Codable {
    var id: UUID?
    var userId: String
    var auctionProduct: AuctionProduct?
    var applyProduct: ApplyProduct?
    var address: Address
    var deliveryRequest: DeliveryMessages
    var deliveryCost: Int
    var paymentMethod: PaymentMethod
    
    enum DeliveryMessages: String, CaseIterable, Identifiable, Codable {
        case door, securityOffice, call, directMessage
        var id: Self {self}
    }
}
