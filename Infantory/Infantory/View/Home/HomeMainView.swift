//
//  HomeView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/20.
//

import SwiftUI

struct HomeMainView: View {
    var searchCategory: SearchResultCategory = .total
    @State private var isShowingDetail = false
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SearchMainView(searchCategory: searchCategory)) {
                    Text("인플루언서 or 경매/응모 키워드 검색")
                        .padding(10)
                        .background(Color.infanLightGray.opacity(0.3))
                        .cornerRadius(5)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMainView()
    }
}
