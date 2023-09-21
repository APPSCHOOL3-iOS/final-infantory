//
//  HomeView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import SwiftUI

struct HomeMainView: View {
    @State var text: String = ""
    var body: some View {
            VStack {
                TextField("asd", text: $text)
            }
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeMainView()
    }
}
