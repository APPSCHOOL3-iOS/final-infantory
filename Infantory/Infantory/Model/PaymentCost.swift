//
//  PaymentInfoViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/20.
//

import Foundation

enum PaymentCost: Int, CaseIterable {
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
    
    func receipt(productPrice: Int) -> Int {
        let commission = productPrice / 10
        let deliveryCost = 3000
        
        switch self {
        case .totalPrice: return productPrice + commission + deliveryCost
        case .price: return productPrice
        case .commission: return commission
        case .deliveryCost: return deliveryCost
        }
    }
}
