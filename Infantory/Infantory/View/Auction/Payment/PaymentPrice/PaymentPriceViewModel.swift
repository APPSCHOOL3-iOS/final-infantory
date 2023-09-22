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
    
    func priceInfo(price: Int) -> Int {
        switch self {
        case .totalPrice: return price + (price / 10) + 3000
        case .price: return price
        case .commission:
            let intCommission = Double(price) / 10
            return Int(intCommission.rounded())
        case .deliveryCost: return 3000
        }
    }
}
