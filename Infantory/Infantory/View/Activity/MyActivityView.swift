//
//  MyActivityView.swift
//  Infantory
//
//  Created by 이희찬 on 10/19/23.
//

import SwiftUI

struct MyActivityView: View {
//    @EnvironmentObject var loginStore: LoginStore
    @StateObject var myActivityStore = MyActivityStore()
    
    var body: some View {
        VStack {
            Button {
                myActivityStore.fetchMyLastBiddingPrice(userID: "uZ9b26iF3vgNuwWKHVX6JQApmux2",
                                                        productID: "ditccvM5YUG8NczgQ00g")
            } label: {
                Text("\(myActivityStore.myBiddingPrice)")
                    .font(.title)
            }
        }
    }
}

#Preview {
    MyActivityView()
}
