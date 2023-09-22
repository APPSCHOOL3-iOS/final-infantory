//
//  PaymentAddressView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/20.
//

import SwiftUI

struct Goods {
    var imgString: String
    var goodsName: String
    
}

struct PaymentAddressView: View {
    @ObservedObject var viewModel: PaymentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            productInfo
            
            addressView
                .padding(.top)
            
            deliveryRequestView
                .padding(.top)
            
        }
        .padding()
    }
}

struct PaymentAddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentAddressView(viewModel: PaymentViewModel())
        }
    }
}

extension PaymentAddressView {
    
    var addressView: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                Text("배송 주소")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    // 주소 변경
                } label: {
                    Text("주소 변경")
                        .font(.footnote)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: 70, height: 25)
                        )
                }
                .buttonStyle(.plain)
            }
            
            ForEach(PaymentAddressViewModel.allCases, id: \.rawValue) { item in
                HStack {
                    Text(item.title)
                        .frame(width: 50, alignment: .leading)
                    Text(item.content)
                }
            }
            
        }
    }
    
    var productInfo: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: viewModel.product.productImageURLStrings[0])) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                } placeholder: {
                    ProgressView()
                }
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 0.5)
                        .frame(width: 100, height: 100)
                )
                .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(viewModel.product.influencerID)
                        .fontWeight(.semibold)
                    
                    Text(viewModel.product.productName)
                    
                    Text(viewModel.product.description)
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
    
    var deliveryRequestView: some View {
        Button {
            // 배송 시 요청사항
        } label: {
            HStack {
                Text("배송 시 요청사항을 선택하세요.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding(.horizontal)
        }
        
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
                .foregroundColor(.gray)
                .frame(height: 45)
        )
        .padding(.top)
    }
}
