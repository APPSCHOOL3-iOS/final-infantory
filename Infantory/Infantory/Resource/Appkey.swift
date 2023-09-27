//
//  Appkey.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/27.
//

import Foundation

struct AppKey {
    static let kakaoAppKey = Bundle.main.infoDictionary?["KakaoAppKey"] ?? ""
}
