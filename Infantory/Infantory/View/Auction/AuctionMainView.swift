//
//  AuctionMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct AuctionMainView: View {
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                AuctionLogoCell()
                Divider()
                AuctionButtonCell()
                ScrollView {
                    ProductListView(userViewModel: UserViewModel(), auctionViewModel: auctionViewModel)
                    Divider()
                }
            }
        }
    }
}

struct AuctionMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionMainView()
    }
}
