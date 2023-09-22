//
//  UserViewModel.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/22.
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published var user: User = User.sampleData
}
