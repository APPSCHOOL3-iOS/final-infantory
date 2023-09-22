//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/21.
//

import Foundation

struct PaymentInfo {
    var product: String
    var deliveryRequest: String
    var price: Int
    var commission: Int
    var deliveryCost: Int
    var paymentMethod: PaymentMethod
}
