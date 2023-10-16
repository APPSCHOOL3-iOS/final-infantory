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
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                    Text(": \(loginStore.totalApplyTicketCount) 장")
                        .font(.infanTitle2)
                }
                .padding(.vertical, 15)
                
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(loginStore.currentUser.applyTicket?.sorted(by: { $0.date > $1.date }) ?? []) { ticket in
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(ticket.date)")
                                        .font(.infanHeadline)
                                    Text("\(ticket.ticketGetAndUse)")
                                    Divider()
                                }
                                Spacer()
                                Text("\(ticket.count)")
                                    .font(.infanTitle2)
                            }
                            .font(.infanHeadlineBold)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .horizontalPadding()
        }
        .navigationTitle("응모권")
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
