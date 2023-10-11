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
                ForEach($applyViewModel.filteredProduct) { $product in
                    VStack {
                        HStack {
                            if product.influencerProfile == nil {
                                Image("Influencer1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)
                                
                            } else {
                                AsyncImage(url: URL(string: product.influencerProfile ?? "")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            Text(product.influencerNickname)
                                .font(.infanFootnoteBold)
                            
                            Spacer()
                            
                            if product.applyFilter == .planned {
                                Text("\(Image(systemName: "timer")) \(InfanDateFormatter.shared.dateTimeString(from: product.startDate)) OPEN")
                                    .font(.infanFootnote)
                                    .foregroundColor(.infanOrange)
                            } else {
                                TimerView(remainingTime: applyViewModel.remainingTime(product: product))
                            }
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 6)
                    .horizontalPadding()
                    
                    NavigationLink {
                        ApplyDetailView(applyViewModel: applyViewModel, product: $product)
                    } label: {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack(spacing: 16) {
                                if product.productImageURLStrings.count > 0 {
                                    
                                    CachedImage(url: product.productImageURLStrings[0]) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .scaledToFill()
                                                .frame(width: (.screenWidth - 100) / 2,
                                                       height: (.screenWidth - 100) / 2)
                                                .clipped()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: (.screenWidth - 100) / 2,
                                                       height: (.screenWidth - 100) / 2)
                                                .clipped()
                                            //
                                        case .failure:
                                            Image(systemName: "xmark")
                                                .frame(width: (.screenWidth - 100) / 2,
                                                       height: (.screenWidth - 100) / 2)
                                            
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                } else {
                                    ZStack(alignment: .topLeading) {
                                        
                                        Image("appleLogo")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: (.screenWidth - 100) / 2,
                                                   height: (.screenWidth - 100) / 2)
                                            .clipped()
                                        
                                    }
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    Text("\(product.productName)")
                                        .font(.infanBody)
                                        .foregroundColor(.infanDarkGray)
                                        .multilineTextAlignment(.leading)
                                    
                                    HStack {
                                        
                                        Text("전체 응모")
                                            .font(.infanHeadline)
                                            .foregroundColor(.infanDarkGray)
                                            .multilineTextAlignment(.leading)
                                        
                                        if product.applyFilter != .planned {
                                            Text("전체 응모: \(product.applyUserIDs.count) 회")
                                                .font(.infanHeadlineBold)
                                                .foregroundColor(.infanDarkGray)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    
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
                                Spacer()
                            }
                        }
                        .horizontalPadding()
                    }
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
