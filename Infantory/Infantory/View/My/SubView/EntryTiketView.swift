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
                    Image("applyTicket")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 30)
                    Text(": \(loginStore.totalApplyTicketCount) 장")
                        .font(.infanTitle2)
                    Spacer()
                }
                .padding([.bottom, .top], 15)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("23.07.21")
                        Text("출석체크")
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Text("+ 1")
                        .padding(.trailing, 30)
                }
                
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("23.07.21")
                        Text("출석체크")
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Text("+ 1")
                        .padding(.trailing, 30)
                }
                
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("23.07.21")
                        Text("출석체크")
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Text("+ 1")
                        .padding(.trailing, 30)
                }
                
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("23.07.21")
                        Text("출석체크")
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Text("+ 1")
                        .padding(.trailing, 30)
                }
                
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("23.07.21")
                        Text("응모 : 바지")
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Text("+ 1")
                        .padding(.trailing, 30)
                }
                
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("23.07.21")
                        Text("응모 : 수지신발")
                    }
                    .padding(.leading, 30)
                    Spacer()
                    Text("+ 1")
                        .padding(.trailing, 30)
                }
            }
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
