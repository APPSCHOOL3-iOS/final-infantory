//
//  ApplyProductListView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/27.
//

import SwiftUI

struct ApplyProductListView: View {
    
    @StateObject var applyViewModel: ApplyProductViewModel
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(applyViewModel.applyProduct) { product in

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
                            Label("03:22:15", systemImage: "timer")
                                .foregroundColor(.infanMain)
                                .font(.infanFootnote)
                                .frame(height: 24)
                                .padding(4)
                        }
                        .infanHorizontalPadding()
                        
                        NavigationLink {
                            ApplyDetailView(product: product)
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
                                                        .frame(width: (.screenWidth - 60) / 2, height: (.screenWidth - 60) / 2)
                                                        .cornerRadius(4)
                                                        .clipped()
                                                }
                                            } placeholder: {
                                                ProgressView()
                                                    .scaledToFill()
                                                    .frame(width: (.screenWidth - 60) / 2, height: (.screenWidth - 60) / 2)
                                                    .cornerRadius(4)
                                                    .clipped()
                                            }
                                        }
                                    } else {
                                        ZStack(alignment: .topLeading) {

                                            Image("appleLogo")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: (.screenWidth - 40) / 2, height: (.screenWidth - 40) / 2)
                                                .cornerRadius(4)
                                                .clipped()

                                            Label("03:22:15", systemImage: "timer")
                                                .foregroundColor(.infanMain)
                                                .font(.infanFootnote)
                                                .frame(height: 24)
                                                .padding(4)
                                        }
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("\(product.productName)")
                                            .font(.infanBody)
                                            .foregroundColor(.infanDarkGray)
                                            .multilineTextAlignment(.leading)

                                        Spacer()
                                        VStack {
                                            Text("시작일  10/4 8:00")
                                                .font(.infanFootnote)
//                                                .foregroundColor(.infanGray)

                                            Text("마감일  10/5 8:00")
                                                .font(.infanFootnote)
//                                                .foregroundColor(.infanGray)
                                        }
                                    }
                                    .padding(.vertical, 10)
                                }
                                Divider()
                            }
                            .infanHorizontalPadding()
                        }
                    }
                    .padding(.top)
                }
            }
        }
//        .onAppear {
//            Task {
//                do {
//                    try await applyViewModel.fetchApplyProducts()
//
//                } catch {
//                }
//            }
//        }
    }
}

struct ApplyProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplyProductListView(applyViewModel: ApplyProductViewModel())
        }
    }
}
