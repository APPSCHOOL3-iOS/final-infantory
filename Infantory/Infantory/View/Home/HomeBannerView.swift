//
//  HomeBannerView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/15.
//

import SwiftUI

struct HomeBannerView: View {
    
    @ObservedObject var applyViewModel: ApplyProductStore
    private var selectedProducts: [ApplyProduct] {
        applyViewModel.applyProduct.filter { product in
            product.applyFilter == .close
        }.filter { product in
            product.applyCloseFilter == .afterRaffle
        }
    }
    var body: some View {
        TabView {
            ForEach(selectedProducts) { product in
                NavigationLink {
                    ApplyDetailView(applyViewModel: applyViewModel, product: product)
                } label: {
                    ZStack(alignment: .center) {
                        Image("finalApplyfinal")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        VStack {
                            Spacer()
                            
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
                                            .frame(width: .screenWidth * 0.585, height: (.screenWidth * 0.666) / 2 - 1)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "xmark")
                                            .frame(width: (.screenWidth - 100) / 2,
                                                   height: (.screenWidth - 100) / 2)
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                
                            } else {
                                Image("smallAppIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (.screenWidth - 100) / 2,
                                           height: (.screenWidth - 100) / 2)
                                    .clipped()
                            }
                        }
                        
                        HStack {
                            Spacer()
                                .frame(width: .screenWidth * 0.6)
                            
                            if product.influencerProfile == nil {
                                Image("smallAppIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(35)
                            } else {
                                CachedImage(url: product.influencerProfile ?? "") { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(35)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(35)
                                    case .failure:
                                        Image(systemName: "xmark")
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(35)
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: .screenWidth, height: .screenWidth * 0.666)
    }
}

struct HomeBannerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBannerView(applyViewModel: ApplyProductStore())
    }
}
