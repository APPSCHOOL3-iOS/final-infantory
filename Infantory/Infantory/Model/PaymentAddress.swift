//
//  PaymentAddressViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import Foundation

enum PaymentAddress: Int, CaseIterable {
    case prizeWinner
    case phoneNumber
    case address
    
    var title: String {
        switch self {
        case .prizeWinner: return "받는 분"
        case .phoneNumber: return "연락처"
        case .address: return "주소"
        }
    }
    
    func content(paymentStore: PaymentStore) -> String {
        switch self {
        case .prizeWinner: return paymentStore.user.name
        case .phoneNumber: return paymentStore.user.phoneNumber
        case .address: return paymentStore.user.address.address
        }
    }
}
