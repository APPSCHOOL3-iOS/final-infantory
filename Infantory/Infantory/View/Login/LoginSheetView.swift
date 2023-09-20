//
//  LoginSheetView.swift
//  Infantory
//
//  Created by 민근의 mac on 2023/09/20.
//

import SwiftUI

struct LoginSheetView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [.blue, .purple]))
                .ignoresSafeArea()
            VStack {
                Text("W E L C O M E").font(.headline.bold())
                    .foregroundColor(.indigo)
                Spacer().frame(height: 30)
                Text("로그인 후").font(.largeTitle.bold())
                Text("이용해주세요.").font(.largeTitle.bold())
                Spacer().frame(height: 30)
                Group {
                    Button {
                        // login 기능 구현
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 330, height: 50)
                                .foregroundColor(.yellow)
                            
                            HStack(alignment: .center) {
                                Image("kakaoLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35)
                                Text("카카오로 계속하기")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .padding(.leading, -5)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        // login 기능 구현
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 330, height: 50)
                                .foregroundColor(.black)

                            
                            HStack(alignment: .center) {
                                Image("appleLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 27)
                                    .clipShape(Circle())
                                Text("Apple로 계속하기")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(.leading, -5)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .presentationDetents([.height(UIScreen.main.bounds.height * 0.7)])
    }
}

struct LoginSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSheetView()
    }
}
