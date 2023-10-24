//
//  CustomerCenter.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/17.
//

import SwiftUI

struct MyAppInfoView: View {
    @State private var showingModalTermsOfUse: Bool = false
    @State private var showingModalPrivacyPolicy: Bool = false
    @State private var showingModalOpenSource: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 17) {
                    Text("앱 정보")
                        .font(.infanTitle2Bold)
                        .foregroundColor(.infanBlack)
                        .padding(.bottom, 10)
                    Button {
                        
                    } label: {
                        Text("글꼴")
                            .foregroundColor(.infanBlack)
                            .font(.infanHeadline)
                    }
                    Divider()
                    Button {
                        
                    } label: {
                        Text("이미지 라이선스")
                            .foregroundColor(.infanBlack)
                            .font(.infanHeadline)
                    }
                    Divider()
                    
                    Text("정보")
                        .font(.infanTitle2Bold)
                        .foregroundColor(.infanBlack)
                        .padding(.bottom, 10)
                    Button {
                        showingModalTermsOfUse.toggle()
                    } label: {
                        Text("이용약관")
                            .foregroundColor(.infanBlack)
                            .font(.infanHeadline)
                    }
                    
                    Group {
                        Divider()
                        Button {
                            showingModalPrivacyPolicy.toggle()
                        } label: {
                            Text("개인정보처리방침")
                                .foregroundColor(.infanBlack)
                                .font(.infanHeadline)
                        }
                        Divider()
                        Button {
                            showingModalOpenSource.toggle()
                        } label: {
                            Text("오픈소스 라이선스")
                                .foregroundColor(.infanBlack)
                                .font(.infanHeadline)
                        }
                        Divider()
                        HStack {
                            Text("버전 1.0.0(23.10.25)")
                                .font(.infanFootnote)
                                .foregroundColor(.infanLightGray)
                            Spacer()
                        }
                    }
                }
                .foregroundColor(.black)
                .padding()
                .navigationBar(title: "고객센터")
            }
        }
    }
}

struct MyAppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyAppInfoView()
    }
}
