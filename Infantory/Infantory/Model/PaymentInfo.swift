//
//  PaymentInfo.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/21.
//

import Foundation
import FirebaseFirestoreSwift

struct PaymentInfo: Codable, Identifiable {
    var id: UUID?
    var userId: String
    var auctionProduct: AuctionProduct? = nil
    var applyProduct: ApplyProduct? = nil
    var address: Address
    var deliveryRequest: DeliveryMessages
    var deliveryCost: Int
    var paymentMethod: PaymentMethod
    
    enum DeliveryMessages: String, CaseIterable, Identifiable, Codable {
        case door, securityOffice, call, directMessage
        var id: Self {self}
    }
    enum ProductType {
        case auction
        case apply
    }
    
    var type: ProductType {
        if auctionProduct != nil {
            return .auction
        } else {
            return .apply
        }
    }
}

#if DEBUG
extension PaymentInfo {
    static let dummy =  PaymentInfo(userId: "",
                                    address: Address.init(address: "",
                                                          zonecode: "",
                                                          addressDetail: ""),
                                    deliveryRequest: .door,
                                    deliveryCost: 3000,
                                    paymentMethod: .accountTransfer)
}
#endif
