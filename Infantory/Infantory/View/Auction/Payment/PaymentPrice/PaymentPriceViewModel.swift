//
//  PaymentInfoViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/20.
//

import Foundation

enum PaymentInfoViewModel: Int, CaseIterable {
    case totalPrice
    case price
    case commission
    case deliveryCost
    
    var title: String {
        switch self {
        case .totalPrice: return "총 결제금액"
        case .price: return "구매가"
        case .commission: return "수수료"
        case .deliveryCost: return "배송비"
        }
    }
    
    var price: Int {
        switch self {
        case .totalPrice:
            return PaymentInfoViewModel.allCases
                .filter { $0 != .totalPrice }
                .reduce(0) { $0 + $1.price }
        case .price: return 100000
        case .commission: return 10000
        case .deliveryCost: return 3000
        }
    }
}
