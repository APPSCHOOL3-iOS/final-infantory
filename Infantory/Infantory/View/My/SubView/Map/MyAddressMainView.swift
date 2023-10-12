//
//  MyMapMainView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/12.
//

import SwiftUI
struct MyAddressMainView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                NavigationLink {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 360, height: 90)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.infanDarkGray, lineWidth: 1)
                            )
                            .foregroundColor(.white)
                            .padding(2)
                        Text("+ 새 주소 추가하기")
                            .font(.infanHeadline)
                            .frame(width: 360, height: 90)
                            .foregroundColor(.infanDarkGray)
                    }
                }
                HStack {
                    MyAddressDetailView()
                    Spacer()
                }
                .horizontalPadding()
            }
        }
    }
}

struct MyAddressMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyAddressMainView()
            .environmentObject(LoginStore())
    }
}
