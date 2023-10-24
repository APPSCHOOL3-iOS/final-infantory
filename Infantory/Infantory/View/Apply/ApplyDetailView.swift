//
//  ApplyDetailView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var applyProductStore: ApplyProductStore
    var product: ApplyProduct
    
    @State private var isShowingActionSheet: Bool = false
    @State private var isShowingReportSheet: Bool = false
    
    @State private var toastMessage: String = ""
    @State private var isShowingToastMessage: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ApplyBuyerView(product: product)
                HStack {
                    ApplyInfluencerImageView(applyProductStore: applyProductStore, product: product)
                    Spacer()
                    
                    Button {
                        isShowingActionSheet = true
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .buttonStyle(.plain)
                }
                .horizontalPadding()
                .padding(.bottom, 5)
                
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
                ToastMessage(content: Text("\(toastMessage)"), isPresented: $isShowingToastMessage)
                productInfo
            }
            
            ApplyFooter(applyProductStore: applyProductStore, product: product, toastMessage: $toastMessage, isShowingToastMessage: $isShowingToastMessage)
        }
        .navigationBar(title: "상세정보")
        .confirmationDialog("", isPresented: $isShowingActionSheet) {
            
            Button("신고하기", role: .destructive) {
                isShowingActionSheet = false
                isShowingReportSheet = true
            }
            
            Button("저장하기", role: .none) {
                
            }
            Button("취소", role: .cancel) {}
        }
        .sheet(isPresented: $isShowingReportSheet) {
            ApplyReportSheetView(product: product, toastMessage: $toastMessage, isShowingToastMessage: $isShowingToastMessage)
        }
    }
}

struct ApplyFooter: View {
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var applyProductStore: ApplyProductStore
    @State private var isShowingApplySheet: Bool = false
    @State private var isShowingLoginSheet: Bool = false
    @State private var isShowingPaymentSheet: Bool = false
    var product: ApplyProduct
    @Binding var toastMessage: String
    @Binding var isShowingToastMessage: Bool
    var body: some View {
        VStack {
            ApplyAddButtonView(isShowingApplySheet: $isShowingApplySheet, 
                               isShowingLoginSheet: $isShowingLoginSheet,
                               isShowingPaymentSheet: $isShowingPaymentSheet,
                               product: product)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 110)
        .offset(x: 0, y: 40)
        .sheet(isPresented: $isShowingApplySheet, onDismiss: {
            Task {
                try await loginStore.fetchUser(userUID: loginStore.userUid)
                try await applyProductStore.fetchApplyProducts()
            }
        }, content: {
            ApplySheetView(applyProductStore: applyProductStore, isShowingApplySheet: $isShowingApplySheet, product: product, toastMessage: $toastMessage, isShowingToastMessage: $isShowingToastMessage)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.45)])
            
        })
        
        .sheet(isPresented: $isShowingPaymentSheet) {
            PaymentMainView(paymentStore: PaymentStore(user: loginStore.currentUser,
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

extension ApplyDetailView {
    var productInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                
                // 남은 시간
                TimerView(remainingTime: applyProductStore.remainingTime(product: product))
                Spacer()
            }
            .horizontalPadding()
            .padding([.top, .bottom], 5)
            
            VStack(alignment: .leading) {
                Text("\(product.productName)")
                    .font(.infanTitle2Bold)
                    .padding(.bottom)
                
                // 제품 설명
                Text("\(product.description)")
                    .font(.infanBody)
                    .foregroundColor(.primary)
                    .padding(.bottom, 100)
                    .multilineTextAlignment(.leading)
            }
            .horizontalPadding()
        }
    }
}

struct ApplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailView(applyProductStore: ApplyProductStore(), product:
                            ApplyProduct(productName: "", productImageURLStrings: [""], description: "", influencerID: "", influencerNickname: "볼빨간사춘기", startDate: Date(), endDate: Date(), registerDate: Date(), applyUserIDs: [""]))
        .environmentObject(LoginStore())
    }
}
