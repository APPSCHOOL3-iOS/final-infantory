//
//  ApplyMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct ApplyMainView: View {
    @StateObject var applyViewModel: ApplyProductViewModel = ApplyProductViewModel()
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
                    ApplyProductListView(applyViewModel: applyViewModel)
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
                    ApplyProductListView(applyViewModel: applyViewModel)
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

struct ApplyMainView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyMainView()
    }
}
