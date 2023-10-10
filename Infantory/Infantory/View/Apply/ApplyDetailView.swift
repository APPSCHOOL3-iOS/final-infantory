//
//  ApplyDetailView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    var applyViewModel: ApplyProductStore
    @Binding var product: ApplyProduct
    
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
                .horizontalPadding()
                
                Text(product.description)
                    .horizontalPadding()
                    .padding(.top)
                    .padding(.bottom, 100)
                    .multilineTextAlignment(.leading)
            }
            
            ApplyFooter(product: $product)
        }
    }
}

struct ApplyFooter: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @State private var isShowingApplySheet: Bool = false
    @State private var isShowingLoginSheet: Bool = false
    @Binding var product: ApplyProduct
    
    var body: some View {
        VStack {
            ApplyAddButtonView(isShowingApplySheet: $isShowingApplySheet, isShowingLoginSheet: $isShowingLoginSheet, product: product)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 110)
        .background(
            Rectangle()
                .stroke(lineWidth: 0.1)
                .background(.white)
            
        )
        .offset(x: 0, y: 40)
        .sheet(isPresented: $isShowingApplySheet, onDismiss: {
            Task {
                try await loginStore.fetchUser(userUID: loginStore.userUid)
            }
        }, content: {
            ApplySheetView(isShowingApplySheet: $isShowingApplySheet, product: $product, viewModel: ApplyProductStore())
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.45)])
        })
        
        .sheet(isPresented: $isShowingLoginSheet, content: {
            LoginSheetView()
                .environmentObject(loginStore)
        })
    }
}

struct ApplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailView(applyViewModel: ApplyProductStore(), product:
                .constant(ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), applyUserIDs: [""])))
        .environmentObject(LoginStore())
    }
}
