//
//  SearchResultView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

struct SearchResultView: View {
    
    var searchText: String
    
    var body: some View {
        Text(searchText)
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchText: "서치텍스트")
    }
}
