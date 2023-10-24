//
//  AuctionMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct AuctionMainView: View {
    @EnvironmentObject var loginStore: LoginStore
    @StateObject var auctionViewModel: AuctionProductViewModel = AuctionProductViewModel()
    var searchCategory: SearchResultCategory = .auction
    
    var body: some View {
        if loginStore.currentUser.isInfluencer == UserType.influencer {
            NavigationStack {
                ZStack {
                    VStack {
                        AuctionFilterButtonView(auctionViewmodel: auctionViewModel)
                        ProductListView(auctionViewModel: auctionViewModel)
                        Divider()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: SearchMainView(searchCategory: searchCategory)) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.infanBlack)
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("경매")
                                .font(.infanHeadlineBold)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    AuctionFloatingButton(action: {
                    }, icon: "plus")
                }
            }
        } else {
            NavigationStack {
                VStack {
                    AuctionFilterButtonView(auctionViewmodel: auctionViewModel)
                    ProductListView(auctionViewModel: auctionViewModel)
                    Divider()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SearchMainView(searchCategory: searchCategory)) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.infanBlack)
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

struct AuctionFloatingButton: View {
    let action: () -> Void
    let icon: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    AuctionRegistrationView()
                } label: {
                    Image(systemName: icon)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.infanMain)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .offset(x: -25, y: -25)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AuctionMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionMainView()
            .environmentObject(LoginStore())
    }
}
