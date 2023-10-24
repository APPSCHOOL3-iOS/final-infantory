//
//  SwiftUIView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/10.
//

import SwiftUI
import PhotosUI
import Photos

struct MyLoginView: View {
    @EnvironmentObject var loginStore: LoginStore
    @Environment(\.dismiss) private var dismiss
    @State var showingAlert: Bool = false
    @State private var isShowingLoginSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // 프사이미지, 닉네임, 응모권 관심상품
                VStack(spacing: 20) {
                    // 로그인 버튼
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.infanMain, lineWidth: 2)
                            .frame(width: (.screenWidth - 50), height: 60)
                            .foregroundColor(.white)
                        Button(action: {
                            isShowingLoginSheet = true
                        }, label: {
                            Text("로그인이 필요한 서비스 입니다.")
                                .frame(width: (.screenWidth - 50), height: 60)
                                .foregroundColor(.infanMain)
                        })
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
                        Button {
                            showingAlert.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "list.bullet.rectangle.portrait")
                                    .frame(width: 24)
                                
                                Text("입찰내역")
                                    .font(.infanHeadline)
                                Spacer()
                            }
                        }
                        Divider()
                        Button {
                            showingAlert.toggle()
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
                        Button {
                            showingAlert.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "tag")
                                    .frame(width: 24)
                                
                                Text("결제정보")
                                    .font(.infanHeadline)
                                Spacer()
                            }
                        }
                    }
                    .foregroundColor(.primary)
                    .listStyle(.plain)
                    
                }
                .horizontalPadding()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("주의"),
                  message: Text("로그인이 필요한 서비스 입니다."),
                  primaryButton: .cancel(Text("확인"), action: {
                dismiss()
            }),
                  secondaryButton: .destructive(Text("취소"), action: {
                dismiss()
            }))
        }
        .sheet(isPresented: $isShowingLoginSheet, content: {
            LoginSheetView()
                .environmentObject(loginStore)
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
struct MyLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MyLoginView()
            .environmentObject(LoginStore())
    }
}
