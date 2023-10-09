//
//  ApplyProductListView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/27.
//

import SwiftUI

struct ApplyProductListView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($applyViewModel.applyProduct) { $product in
                    VStack {
                        HStack {
                            Image("Influencer1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                            
                            Text(product.influencerNickname)
                                .font(.infanFootnoteBold)
                            
                            Spacer()
                            TimerView(remainingTime: applyViewModel.remainingTime(product: product))
                        }
                        .horizontalPadding()
                        
                        NavigationLink {
                            ApplyDetailView(applyViewModel: applyViewModel, product: $product)
                        } label: {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 16) {
                                    if product.productImageURLStrings.count > 0 {
                                        if let url = URL(string: product.productImageURLStrings[0]) {
                                            AsyncImage(url: url) { image in
                                                ZStack(alignment: .topLeading) {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                                        .clipped()
                                                }
                                            } placeholder: {
                                                ProgressView()
                                                    .scaledToFill()
                                                    .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                                    .clipped()
                                            }
                                        }
                                    } else {
                                        Image("appleLogo")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 100) / 2, height: (.screenWidth - 100) / 2)
                                            .clipped()
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("\(product.productName)")
                                            .font(.infanBody)
                                            .foregroundColor(.infanDarkGray)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                        VStack {
                                            Text("시작일  \(InfanDateFormatter.shared.dateTimeString(from: product.startDate))")
                                                .font(.infanFootnote)
                                                .foregroundColor(.infanGray)
                                            
                                            Text("마감일  \(InfanDateFormatter.shared.dateTimeString(from: product.endDate))")
                                                .font(.infanFootnote)
                                                .foregroundColor(.infanGray)

                                        }
                                    }
                                }
                                Divider()
                            }
                            .horizontalPadding()
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await applyViewModel.fetchApplyProducts()
                } catch {
                }
            }
        }
    }
}

struct ApplyProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplyProductListView(applyViewModel: ApplyProductStore())
        }
    }
}
