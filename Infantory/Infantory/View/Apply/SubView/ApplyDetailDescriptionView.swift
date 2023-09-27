//
//  ApplyDetailDescriptionView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailDescriptionView: View {
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    
    var body: some View {
        VStack {
//            Text("\(auctionProductViewModel.auctionProduct[0].productName)")
//            Text("\(auctionProductViewModel.auctionProduct[0].description)")
            
            Button(action: {
                
            }, label: {
                Text("응모하기")
                    .font(.infanTitle)
                    .frame(width: 150, height: 20)
                    .padding()
                    .foregroundColor(.infanDarkGray)
                    .background(Color.infanYellow)
                    .cornerRadius(15)
            })
        }
    }
}

struct ApplyDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailDescriptionView(auctionProductViewModel: AuctionProductViewModel())
    }
}
