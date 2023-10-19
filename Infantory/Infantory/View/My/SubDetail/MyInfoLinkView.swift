//
//  MyInfoLinkView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/19.
//

import SwiftUI

struct MyInfoLinkView: View {
    @Environment(\.dismiss) private var dismiss
    
    var loginStore: LoginStore
    var myPaymentStore: MyPaymentStore
    @State private var isAlertShowing: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NavigationLink {
                MyPaymentsListView(myPaymentStore: myPaymentStore)
            } label: {
                HStack {
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .frame(width: 24)
                    
                    Text("결제정보")
                        .font(.infanHeadline)
                        .padding(.leading, 5)
                    Spacer()
                }
            }
            Divider()
            NavigationLink {
                MyAppInfoView()
            } label: {
                HStack {
                    Image(systemName: "megaphone")
                        .frame(width: 24)
                    
                    Text("앱 정보")
                        .font(.infanHeadline)
                        .padding(.leading, 5)
                    Spacer()
                }
            }
            Divider()
            NavigationLink {
                
            } label: {
                HStack {
                    Image(systemName: "person.2")
                        .frame(width: 24)
                    
                    Text("1:1 문의")
                        .font(.infanHeadline)
                        .padding(.leading, 5)
                    Spacer()
                }
            }
            Divider()
            HStack {
                Button(action: {
                    isAlertShowing.toggle()
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .frame(width: 24)
                    
                    Text("로그아웃")
                        .font(.infanHeadline)
                        .padding(.leading, 5)
                    Spacer()
                })
                .foregroundColor(.infanRed)
            }
        }
        .foregroundColor(.infanBlack)
        .listStyle(.plain)
        .alert(isPresented: $isAlertShowing) {
            Alert(title: Text(""),
                  message: Text("로그아웃 하시겠습니까?"),
                  primaryButton: .cancel(Text("확인"), action: {
                loginStore.kakaoLogout()
            }),
                  secondaryButton: .destructive(Text("취소"), action: {
                dismiss()
            }))
        }
    }
}

struct MyInfoLinkView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoLinkView(loginStore: LoginStore(), myPaymentStore: MyPaymentStore())
    }
}
