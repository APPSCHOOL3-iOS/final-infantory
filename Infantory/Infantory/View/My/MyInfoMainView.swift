//
//  SwiftUIView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/10.
//

import SwiftUI
import PhotosUI
import Photos

struct MyInfoMainView: View {
    @StateObject var myPaymentStore: MyPaymentStore = MyPaymentStore()
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    //    @StateObject var photosSelectorStore: PhotosSelectorStore = PhotosSelectorStore.shared
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        VStack {
            // 프사이미지, 닉네임, 응모권 관심상품
            VStack(spacing: 20) {
                MyUserProfileView(loginStore: loginStore)
                
                // 프로필 관리, 배송지 관리 버튼
                MyProfileEditButton(loginStore: loginStore)
                
                // 상품 내역, 결제완료~배송완료
                MyPaymentStatusView(myPaymentStore: myPaymentStore)
                
                // 입찰내역, 응모내역, 결제정보, 로그아웃
                MyInfoLinkView(loginStore: loginStore, myPaymentStore: myPaymentStore)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("고객센터 1599-2892")
                            .font(.infanHeadlineBold)
                            .padding(.bottom, 8)
                        Text("운영시간 평일 09:00 ~ 18:00(토,일,공휴일 휴무)")
                            .font(.infanFootnoteBold)
                            .foregroundColor(.infanLightGray)
                        Text("점심시간 평일 12:00 ~ 13:00")
                            .font(.infanFootnoteBold)
                            .foregroundColor(.infanLightGray)
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(Color.infanDarkGray, lineWidth: 1)
                                    .frame(width: (.screenWidth - 50), height: 30)
                                    .foregroundColor(.white)
                                Button {
                                    
                                } label: {
                                    Text("1:1 문의")
                                        .font(.infanBody)
                                        .foregroundColor(.infanBlack)
                                        .frame(width: (.screenWidth - 50), height: 30)
                                }
                            }
                        }
                        .padding(.vertical, 15)
                    }
                    Spacer()
                }
            }
            .padding(.vertical)
            .horizontalPadding()
        }
        .task({
           Task {
               try await myPaymentStore.fetchMyPayments(userId: loginStore.currentUser.id ?? "")
           }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("마이")
                    .font(.infanHeadlineBold)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct MyInfoMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoMainView()
            .environmentObject(LoginStore())
    }
}
