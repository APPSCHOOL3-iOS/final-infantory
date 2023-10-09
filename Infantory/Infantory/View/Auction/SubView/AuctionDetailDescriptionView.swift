//
//  AuctionDetailDescriptionView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/25.
//

import SwiftUI

struct AuctionDetailDescriptionView: View {
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    
    var body: some View {
        VStack {
//            Text("\(auctionProductViewModel.auctionProduct[0].productName)")
//            Text("\(auctionProductViewModel.auctionProduct[0].description)")
            
            Button(action: {
                
            }, label: {
                Text("경매하기")
                    .font(.infanTitle)
                    .frame(width: 150, height: 20)
                    .padding()
                    .foregroundColor(.infanDarkGray)
                    .background(Color.infanYellow)
                    .cornerRadius(10)
            })
        }
    }
}

struct AuctionDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionDetailDescriptionView(auctionProductViewModel: AuctionProductViewModel())
    }
}
