//
//  AuctionMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct AuctionMainView: View {
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        if userViewModel.user.isInfluencer == UserType.influencer {
            NavigationStack {
                VStack {
                    NavigationLink {
                        AuctionRegistrationView()
                    } label: {
                        Text("임시")
                    }
                    Divider()
                    AuctionButtonCell()
                    ProductListView(userViewModel: UserViewModel(), auctionViewModel: auctionViewModel)
                    Divider()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("경매")
                            .font(.infanHeadlineBold)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        } else {
            NavigationStack {
                VStack {
                    Divider()
                    AuctionButtonCell()
                    ProductListView(userViewModel: UserViewModel(), auctionViewModel: auctionViewModel)
                    Divider()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EmptyView()) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("경매")
                            .font(.infanHeadlineBold)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AuctionMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionMainView()
    }
}
