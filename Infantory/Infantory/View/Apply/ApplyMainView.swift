//
//  ApplyMainView.swift
//  Infantory
//
//  Created by 김성훈 on 2023/09/21.
//

import SwiftUI

struct ApplyMainView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @StateObject var applyViewModel: ApplyProductStore = ApplyProductStore()

    var body: some View {
        if loginStore.currentUser.isInfluencer == UserType.influencer {
            NavigationStack {
                ZStack {
                    VStack {
                        Divider()
                        ApplyFilterButtonView(applyViewModel: applyViewModel)
                        switch applyViewModel.selectedFilter {
                        case .inProgress:
                            ApplyProductListView(applyViewModel: applyViewModel)
                        case .planned:
                            ApplyProductListView(applyViewModel: applyViewModel)
                        case .close:
                            ApplyProductListView(applyViewModel: applyViewModel)
                        }
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
                            Text("응모")
                                .font(.infanHeadlineBold)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    ApplyFloatingButton(action: {
                    }, icon: "plus")
                }
            }
            .onAppearFetchUser()
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
                        Text("응모")
                            .font(.infanHeadlineBold)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppearFetchUser()
        }
    }
}
struct ApplyFloatingButton: View {
    let action: () -> Void
    let icon: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    ApplyRegistrationView()
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

struct ApplyMainView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyMainView()
            .environmentObject(LoginStore())
    }
}
