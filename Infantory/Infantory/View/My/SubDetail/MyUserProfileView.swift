////
////  MyUserProfileView.swift
////  Infantory
////
////  Created by 봉주헌 on 2023/10/19.
////
//
//import SwiftUI
//
//struct MyUserProfileView: View {
//    @ObservedObject var myProfileEditStore: MyProfileEditStore
//    @ObservedObject var loginStore: LoginStore
//    
//    @Binding var nickName: String
//    // 원래 저장돼있는 값 = loginStore.currentUser
//    // 바꿔준 값 = myPaymentStore.myPayments
//    var body: some View {
//        HStack(spacing: 16) {
//            CachedImage(url: myProfileEditStore.user?.profileImageURLString ?? "") { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                        .frame(width: 80, height: 80)
//                case .success(let image):
//                    image
//                        .resizable()
//                        .clipShape(Circle())
//                        .frame(width: 80, height: 80)
//                case .failure:
//                    Image("smallAppIcon")
//                        .resizable()
//                        .clipShape(Circle())
//                        .frame(width: 80, height: 80)
//                @unknown default:
//                    EmptyView()
//                }
//            }
//            
//            VStack(alignment: .leading, spacing: 10) {
//                Text("\(nickName)")
//                    .font(.infanTitle2)
//                    .foregroundColor(.infanBlack)
//                HStack {
//                    NavigationLink {
//                        EntryTicketView()
//                    } label: {
//                        Text("응모권: ")
//                        Text("\(myProfileEditStore.user?.applyTicket?.count ?? 0)장")
//                            .font(.infanFootnoteBold)
//                            .foregroundColor(.infanMain)
//                            .padding(.leading, -5)
//                    }
//                    Divider()
//                        .frame(height: 15)
//                        .background(Color.gray)
//                    NavigationLink {
//                        Text("내가 팔로우한 인플루언서가 보여질 예정입니다.")
//                    } label: {
//                        Text("팔로잉: ")
//                        Text("15K")
//                            .font(.infanFootnoteBold)
//                            .foregroundColor(.infanMain)
//                            .padding(.leading, -5)
//                    }
//                }
//                .font(.infanFootnote)
//                .foregroundColor(.infanBlack)
//            }
//            Spacer()
//        }
//    }
//}
//
//struct MyUserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyUserProfileView(myProfileEditStore: MyProfileEditStore(), loginStore: LoginStore(), nickName: .constant(""))
//    }
//}
