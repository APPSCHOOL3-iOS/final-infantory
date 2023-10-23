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
    @StateObject var myProfileEditStore: MyProfileEditStore = MyProfileEditStore()
    @EnvironmentObject var loginStore: LoginStore
    //    @StateObject var photosSelectorStore: PhotosSelectorStore = PhotosSelectorStore.shared
    @State var nickName: String
    
    var body: some View {
        ScrollView {
            VStack {
                // 프사이미지, 닉네임, 응모권 관심상품
                VStack(spacing: 20) {
                    HStack {
//                        MyUserProfileView(myProfileEditStore: myProfileEditStore, loginStore: loginStore, nickName: $nickName)
                        MyUserProfileView(myProfileEditStore: myProfileEditStore)
                        
                        // 프로필 관리, 배송지 관리 버튼
                        MyProfileEditButton(myProfileEditStore: myProfileEditStore)
                    }
                    .horizontalPadding()
                    
                    // 상품 내역, 결제완료~배송완료
                    Divider()
                    MyPaymentStatusView(myPaymentStore: myPaymentStore, loginStore: loginStore)
                        .horizontalPadding()
                    Divider()
                    // 입찰내역, 응모내역, 결제정보, 로그아웃
                    MyInfoLinkView(loginStore: loginStore, myPaymentStore: myPaymentStore)
                        .horizontalPadding()
                    Spacer()
                    // 고객센터, 장소, 주소, 번호, 상호명
                    MyConsumerCenterView()
                }
                .padding([.vertical, .bottom])
                .horizontalPadding()
            }
        }
        .task {
            Task {
                if !loginStore.userUid.isEmpty {
                    myProfileEditStore.fetchUser(userID: loginStore.userUid)
                }
            }
        }
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
        MyInfoMainView(nickName: "")
    }
}
