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
                ZStack {
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
                    AuctionFloatingButton(action: {
                        print("push ok")
                    }, icon: "plus")
                }
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
            }
            
        }
    }
}
struct AuctionMainView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionMainView()
    }
}
