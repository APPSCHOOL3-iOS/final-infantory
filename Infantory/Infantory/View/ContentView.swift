//
//  ContentView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import SwiftUI

struct ContentView: View {
    var AA: String = "@@@@@@@@@@@@@"
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
