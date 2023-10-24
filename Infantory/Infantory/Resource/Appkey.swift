//
//  Appkey.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/27.
//

import Foundation

struct AppKey {
    
    static let kakaoAppKey = {
        guard let value = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
//            return ""
        }
        
        return value
    }()
    
}
