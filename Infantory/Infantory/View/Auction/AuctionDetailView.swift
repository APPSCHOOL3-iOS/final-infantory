//
//  AuctionDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/25.
//

import SwiftUI

struct AuctionDetailView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                    Text("\(userViewModel.user.name)")
                    Spacer()
                    
                    HStack {
                        Image(systemName: "ticket")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)
                        Text(": \(userViewModel.user.applyTicket[0].count)")
                            .font(.infanBody)
                            .bold()
                    }
                }
                Divider()
                    .padding([.horizontal, .top])
                AuctionDetailImageView(auctionProductVIewModel: auctionProductViewModel)
                AuctionDetailDescriptionView(auctionProductViewModel: auctionProductViewModel)
            }
        }
    }
}

struct AuctionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionDetailView(userViewModel: UserViewModel(), auctionProductViewModel: AuctionProductViewModel())
    }
}
