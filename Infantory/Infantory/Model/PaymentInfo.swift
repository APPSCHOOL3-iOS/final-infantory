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
    var deliveryRequest: String
    var deliveryCost: Int
    var paymentMethod: PaymentMethod
}
