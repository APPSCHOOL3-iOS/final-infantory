//
//  ActivityOption.swift
//  Infantory
//
//  Created by 변상필 on 10/11/23.
//

import SwiftUI

enum ActivityOption: Int, CaseIterable {
    case auction
    case apply
    
    var title: String {
        switch self {
        case .auction:
            return "경매"
        case .apply:
            return "응모"
        }
    }
}
