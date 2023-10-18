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
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    //    @StateObject var photosSelectorStore: PhotosSelectorStore = PhotosSelectorStore.shared
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            // 프사이미지, 닉네임, 응모권 관심상품
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    CachedImage(url: loginStore.currentUser.profileImageURLString ?? "") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 80)
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                            
                        case .failure(let error):
                            Image("smallAppIcon")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(loginStore.currentUser.nickName)")
                            .font(.infanTitle2)
                        
                    }
                    Spacer()
                }
                
                // 프로필 관리, 배송지 관리 버튼
                HStack(spacing: 10) {
                    NavigationLink {
                        ProfileEditView(nickName: loginStore.currentUser.nickName,
                                        phoneNumber: loginStore.currentUser.phoneNumber,
                                        myZipCode: loginStore.currentUser.address.zonecode,
                                        myAddress: loginStore.currentUser.address.address,
                                        myDetailAddress: loginStore.currentUser.address.addressDetail)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(Color.infanDarkGray, lineWidth: 1)
                                .frame(width: (.screenWidth - 50), height: 30)
                                .foregroundColor(.white)
                            
                            Text("프로필 편집")
                                .font(.infanBody)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                }
                
                // 상품 내역, 결제완료~배송완료
                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        Text("상품 내역")
                            .font(.infanHeadlineBold)
                        Spacer()
                    }
                    
                    // 결제완료 준비중 배송중 배송완료
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.infanLightGray.opacity(0.3))
                        
                        HStack {
                            VStack(spacing: 8) {
                                Text("0")
                                    .foregroundColor(.infanMain)
                                    .font(.infanHeadlineBold)
                                Text("결제완료")
                                    .font(.infanFootnote)
                            }
                            .frame(width: (.screenWidth - 70) / 4)
                            
                            Rectangle()
                                .fill(Color.infanLightGray)
                                .frame(width: 1)
                            
                            VStack(spacing: 8) {
                                Text("0")
                                    .font(.infanHeadlineBold)
                                Text("준비중")
                                    .font(.infanFootnote)
                            }
                            .frame(width: (.screenWidth - 70) / 4)
                            
                            VStack(spacing: 8) {
                                Text("0")
                                    .font(.infanHeadlineBold)
                                Text("배송중")
                                    .font(.infanFootnote)
                            }
                            .frame(width: (.screenWidth - 70) / 4)
                            
                            VStack(spacing: 8) {
                                Text("0")
                                    .font(.infanHeadlineBold)
                                Text("배송완료")
                                    .font(.infanFootnote)
                            }
                            .frame(width: (.screenWidth - 70) / 4)
                            
                        }
                        .padding(.vertical, 16)
                        .foregroundColor(Color.black)
                    }
                }
                
                // 입찰내역, 응모내역, 결제정보, 로그아웃
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink {
                        MyPaymentsListView()
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.rectangle.portrait")
                                .frame(width: 24)
                            
                            Text("결제정보")
                                .font(.infanHeadline)
                            Spacer()
                        }
                    }
                    Divider()
                    NavigationLink {
                        EntryTicketView()
                    } label: {
                        HStack {
                            Image("apply")
                                .frame(width: 24)
                            
                            Text("응모내역")
                                .font(.infanHeadline)
                            Spacer()
                        }
                    }
                    Divider()
                    NavigationLink {
                        //                            CustomerCenterView()
                        MyAppInfoView()
                    } label: {
                        HStack {
                            Image(systemName: "megaphone")
                                .frame(width: 24)
                            
                            Text("앱 정보")
                                .font(.infanHeadline)
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
                            Spacer()
                        })
                        .foregroundColor(.infanRed)
                    }
                }
                
                .foregroundColor(.primary)
                .listStyle(.plain)
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
                                        .foregroundColor(.black)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("마이")
                    .font(.infanHeadlineBold)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Image("applyTicket")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .aspectRatio(contentMode: .fit)
                    Text(": \(loginStore.totalApplyTicketCount) 장")
                        .font(.infanHeadline)
                }
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
