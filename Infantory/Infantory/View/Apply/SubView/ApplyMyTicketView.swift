//
//  ApplyMyTicketView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/04.
//

import SwiftUI

struct ApplyMyTicketView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    
    var body: some View {
        HStack {
            Text("내 응모권 갯수")
            Spacer()
            
            Image("applyTicket")
                .resizable()
                .frame(width: 30, height: 30)
                .aspectRatio(contentMode: .fit)
            Text("\(loginStore.totalApplyTicketCount) 장")
                .font(.infanTitle2)
            // Text("1 장")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .fill(Color.infanDarkGray))
        .infanHorizontalPadding()
        .frame(width: CGFloat.screenWidth, height: 80)
    }
}

struct ApplyMyTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyMyTicketView()
            .environmentObject(LoginStore())
    }
}
