//
//  PaymentAddressViewModel.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import Foundation

enum PaymentAddressViewModel: Int, CaseIterable {
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
    
    func content(viewModel: PaymentViewModel) -> String {
        switch self {
        case .prizeWinner: return User.dummyUser.name
        case .phoneNumber: return User.dummyUser.phoneNumber
        case .address: return User.dummyUser.address.addressDetail // 요기 바꿈
        }
    }
}
