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
    @State private var isShowingActionSheet: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                    ApplyBuyerView(product: product)
                HStack {
                    if product.influencerProfile == nil {
                        Image("Influencer1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    } else {
                        AsyncImage(url: URL(string: product.influencerProfile ?? ""), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                        }, placeholder: {
                            ProgressView()
                        })
                    }
                   
                    Text(product.influencerNickname)
                    Spacer()
                    
                    Button(action: {
                        isShowingActionSheet = true
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
                    .buttonStyle(.plain)
                }
                .horizontalPadding()
                
                TabView {
                    ForEach(product.productImageURLStrings, id: \.self) { item in
                        AsyncImage(url: URL(string: item)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                .cornerRadius(10)
                Text(product.description)
                    .horizontalPadding()
                    .padding(.top)
                    .padding(.bottom, 100)
                    .multilineTextAlignment(.leading)
            }
            
            ApplyFooter(product: $product)
        }
        .confirmationDialog("", isPresented: $isShowingActionSheet) {
            
            Button("차단하기", role: .destructive) {
                
            }
            
            Button("저장하기", role: .none) {
                
            }
            Button("취소", role: .cancel) {}
            
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
