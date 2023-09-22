//
//  AuctionMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct AuctionMainView: View {
    var body: some View {
        VStack {
            AuctionLogoCell()
            Divider()
            AuctionButtonCell()
            ScrollView {
                ProductCell()
                Divider()
            }
        }
    }
}

struct AuctionMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionMainView()
    }
}
