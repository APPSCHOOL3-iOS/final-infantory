//
//  Theme.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/17.
//

import SwiftUI

struct Theme {
    static func backgroundColor(forScheme scheme: ColorScheme) -> Color {
        let lightColor = Color.white
        let darkColor = Color.orange
            
        switch scheme {
        case .light:
            return lightColor
        case .dark:
            return darkColor
        @unknown default: return lightColor
        }
    }
}

struct Darkmode: View {
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ZStack {
            Theme.backgroundColor(forScheme: scheme)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
