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
        if userViewModel.user.isInfluencer != UserType.influencer {
            NavigationStack {
                ZStack {
                    VStack {
                        NavigationLink {
                            ApplyRegistrationView()
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
                    }
                    FloatingButton(action: {
                        print("push ok")
                    }, icon: "plus")
                }
            }
        } else {
            NavigationStack {
                ZStack {
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
                    }
                    FloatingButton(action: {
                        print("push ok")
                    }, icon: "plus")
                }
            }
        }
    }
}
struct FloatingButton: View {
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
<<<<<<< Updated upstream
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
=======
                    Image(systemName: icon)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.infanMain)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .offset(x: -25, y: -25)
>>>>>>> Stashed changes
                }
            }
            
        }
    }
}
struct ApplyMainView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyMainView()
    }
}
