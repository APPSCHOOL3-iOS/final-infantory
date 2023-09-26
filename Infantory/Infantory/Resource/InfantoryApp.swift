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
    
    var body: some Scene {
        WindowGroup {
           // MainTabView()
            LoginMainView()
        }
    }
    
    init() {
            // Kakao SDK 초기화
            KakaoSDK.initSDK(appKey: "45ce2063d86a5a5c18e38528aae46993")
    }
}
