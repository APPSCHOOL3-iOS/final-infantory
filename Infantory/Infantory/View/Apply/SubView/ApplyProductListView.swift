//
//  ApplyProductListView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/27.
//

import SwiftUI

struct ApplyProductListView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var applyProductViewModel: ApplyProductViewModel
    @State private var heartButton: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(applyProductViewModel.applyProduct) { product in
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                        
                        Text("\(userViewModel.user.name)")
                            .font(.infanHeadline)
                        
                        Spacer()
                        Button(action: {
                            heartButton.toggle()
                        }, label: {
                            Image(systemName: heartButton ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(.infanDarkGray)
                        })
                    }
                    .infanHorizontalPadding()
                    
                    NavigationLink {
                        ApplyDetailView(userViewModel: userViewModel, applyProductViewModel: applyProductViewModel)
                    } label: {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                if product.productImageURLStrings.count > 0 {
                                    Image("\(product.productImageURLStrings[0])")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 140)
                                } else {
                                    Image("appleLogo")
                                        .resizable()
                                        .frame(width: 150, height: 140)
                                }
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        Text("Hot")
                                            .font(.infanFootnote)
                                            .frame(width: 40, height: 20)
                                            .foregroundColor(.infanDarkGray)
                                            .background(Color.infanRed)
                                            .cornerRadius(10)
                                        Text("New")
                                            .font(.infanFootnote)
                                            .frame(width: 40, height: 20)
                                            .foregroundColor(.infanDarkGray)
                                            .background(Color.infanGreen)
                                            .cornerRadius(10)
                                    }
                                    VStack(alignment: .leading, spacing: 20) {
                                        Text("상품명: \(product.productName)")
                                            .font(.infanTitle2)
                                            .foregroundColor(.infanDarkGray)
                                        VStack(alignment: .leading) {
                                            Text("남은시간: 03:02:01")
                                                .font(.infanBody)
                                                .foregroundColor(.infanDarkGray)
                                            Text("응모 횟수: \(product.applyUserIDs.count )")
                                                .font(.infanBody)
                                                .foregroundColor(.infanDarkGray)
                                        }
                                    }
                                }
                            }
                            .infanHorizontalPadding()
                            Rectangle()
                                .fill(Color.infanLightGray)
                                .frame(height: 2)
                        }
                    }
                }
            }
        }
        .padding(.vertical)
        .onAppear {
            Task {
                do {
                    try await applyProductViewModel.fetchApplyProducts()
                } catch {
                    
                }
            }
        }
    }
}

struct ApplyProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplyProductListView(userViewModel: UserViewModel(), applyProductViewModel: ApplyProductViewModel())
        }
    }
}
