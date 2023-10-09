//
//  InfantoryApp.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import Photos

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct InfantoryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: AppKey.kakaoAppKey)
    }
    
    @StateObject private var loginStore = LoginStore()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                MainTabView()
                    .onOpenURL { url in
                        if AuthApi.isKakaoTalkLoginUrl(url) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
            .environmentObject(loginStore)
        }
    }
}
