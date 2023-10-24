//
//  ApplyFilter.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/06.
//

import Foundation

enum ApplyFilter: String, CaseIterable {
    case inProgress = "진행 응모"
    case planned = "예정 응모"
    case close = "종료 응모"
}

enum ApplyInprogressFilter: String, CaseIterable {
    case deadline = "마감순"
    case popular = "인기순"
}

enum ApplyCloseFilter: String, CaseIterable {
    case beforeRaffle = "추첨 전"
    case afterRaffle = "추첨 후"
}
