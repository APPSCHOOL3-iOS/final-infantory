//
//  EntryTiketView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/13.
//

import SwiftUI

struct EntryTicketView: View {
    @EnvironmentObject var loginStore: LoginStore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    Image("applyTicket")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                    Text(": \(loginStore.totalApplyTicketCount) 장")
                        .font(.infanHeadlineBold)
                }
                .padding(.vertical, 15)
                
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(loginStore.currentUser.applyTicket?.sorted(by: { $0.date > $1.date }) ?? []) { ticket in
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(ticket.date)")
                                        .font(.infanFootnote)
                                    Text("\(ticket.ticketGetAndUse)")
                                        .font(.infanHeadlineBold)
                                }
                                Spacer()
                                Text("\(ticket.count)")
                                    .font(.infanHeadlineBold)
                            }
                            Divider()
                            .font(.infanHeadlineBold)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .horizontalPadding()
        }
        .navigationBar(title: "응모권")
    }
}

struct EntryTicketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EntryTicketView()
                .environmentObject(LoginStore())
        }
    }
}
