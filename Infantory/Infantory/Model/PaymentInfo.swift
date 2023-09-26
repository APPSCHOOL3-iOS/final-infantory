//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/21.
//

import Foundation

struct PaymentInfo {
    var product: String //productID
    var address: Address
    var deliveryRequest: DeliveryMessages
    var deliveryCost: Int
    var paymentMethod: PaymentMethod
    
    enum DeliveryMessages: String, CaseIterable, Identifiable {
        case door, securityOffice, call, directMessage
        var id: Self {self}
    }
}
