//
//  AuctionMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct AuctionMainView: View {
    @EnvironmentObject var auctionViewModel: AuctionProductViewModel
    
    var body: some View {
        VStack {
            AuctionLogoCell()
            Divider()
            AuctionButtonCell()
            ScrollView {
                ProductListView(userViewModel: UserViewModel(), auctionViewModel: AuctionProductViewModel())
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
