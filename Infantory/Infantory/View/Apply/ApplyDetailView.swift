//
//  ApplyDetailView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var applyViewModel: ApplyProductStore
    var product: ApplyProduct
    @State private var isShowingActionSheet: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                    ApplyBuyerView(product: product)
                HStack {
                    CachedImage(url: product.influencerProfile ?? "") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaledToFill()
                                .frame(width: (.screenWidth - 100) / 2,
                                       height: (.screenWidth - 100) / 2)
                                .clipped()
                        case .success(let image):
                            image
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            //
                        case .failure:
                            Image("smallAppIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            
                        @unknown default:
                            EmptyView()
                        }
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
                        CachedImage(url: item) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .scaledToFill()
                                    .clipped()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                            case .failure:
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                
                            @unknown default:
                                EmptyView()
                            }
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
            
            ApplyFooter(applyViewModel: applyViewModel, product: product)
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
    @ObservedObject var applyViewModel: ApplyProductStore
    @State private var isShowingApplySheet: Bool = false
    @State private var isShowingLoginSheet: Bool = false
    @State private var isShowingPaymentSheet: Bool = false
    var product: ApplyProduct
    
    var body: some View {
        VStack {
            ApplyAddButtonView(isShowingApplySheet: $isShowingApplySheet, 
                               isShowingLoginSheet: $isShowingLoginSheet,
                               isShowingPaymentSheet: $isShowingPaymentSheet,
                               product: product)
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
                try await applyViewModel.fetchApplyProducts()
            }
        }, content: {
            ApplySheetView(applyViewModel: applyViewModel, isShowingApplySheet: $isShowingApplySheet, product: product)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.45)])

        })
        
        .sheet(isPresented: $isShowingPaymentSheet) {
            PaymentView(paymentStore: PaymentStore(user: loginStore.currentUser,
                                                   product: product),
                        paymentInfo: PaymentInfo(userId: loginStore.currentUser.id ?? "",
                                                 auctionProduct: nil,
                                                 applyProduct: product,
                                                 address: loginStore.currentUser.address,
                                                 deliveryRequest: .door,
                                                 deliveryCost: 3000,
                                                 paymentMethod: PaymentMethod.accountTransfer),
                        isShowingPaymentSheet: $isShowingPaymentSheet
            )
        }
        
        .sheet(isPresented: $isShowingLoginSheet, content: {
            LoginSheetView()
                .environmentObject(loginStore)
        })
    }
}

struct ApplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailView(applyViewModel: ApplyProductStore(), product:
                            ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), registerDate: Date(), applyUserIDs: [""]))
        .environmentObject(LoginStore())
    }
}
