//
//  ApplyDetailView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    var product: ApplyProduct
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ApplyBuyerView(product: product)
                HStack {
                    Image("Influencer1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                    Text(product.influencerNickname)
                        .font(.infanTitle2)
                    Spacer()
                }
                .infanHorizontalPadding()
                
                ApplyItemImageView()
                    .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                    .cornerRadius(8)
            }
            
            ApplyFooter()
        }
    }
}

struct ApplyFooter: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @State private var isShowingApplySheet: Bool = false
    @State private var isShowingLoginSheet: Bool = false
    
    var body: some View {
        VStack {
            Button {
                if loginStore.userUid.isEmpty {
                    isShowingLoginSheet = true
                } else {
                    isShowingApplySheet.toggle()
                }
            } label: {
                Text("응모하기")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.infanMain)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            }
            .offset(y: -20)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 110)
        .background(
            Rectangle()
                .stroke(lineWidth: 0.1)
                .background(.white)
            
        )
        .offset(x: 0, y: 40)
        .sheet(isPresented: $isShowingApplySheet) {
            ApplySheetView()
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.3)])
        }
        .sheet(isPresented: $isShowingLoginSheet, content: {
            LoginSheetView(isShowingSignUp: $isShowingLoginSheet)
                .environmentObject(loginStore)
        })
    }
}

struct ApplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailView(product: ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), applyUserIDs: [""]))
            .environmentObject(LoginStore())
    }
}
