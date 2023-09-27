//
//  AuctionFilter.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/26.
//

import Foundation

enum AuctionFilter: String, CaseIterable {
    case inProgress = "진행 경매"
    case planned = "예정 경매"
    case close = "종료 경매"
}
