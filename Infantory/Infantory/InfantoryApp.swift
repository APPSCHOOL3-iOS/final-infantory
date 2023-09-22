//
//  InfantoryApp.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import FirebaseCore
import SwiftUI

@main
struct InfantoryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      FirebaseApp.configure()

    return true
  }
}
