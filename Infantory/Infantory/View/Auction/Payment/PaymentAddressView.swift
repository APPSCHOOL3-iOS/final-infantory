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
    var body: some View {
            VStack {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: "https://dimg.donga.com/wps/NEWS/IMAGE/2021/12/11/110733453.1.jpg")) { image in
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
                        Text("B75806")
                            .fontWeight(.semibold)
                        
                        Text("Adidas Samba OG Cloud White")
                        
                        Text("제품에 대한 정보")
                            .foregroundColor(.gray)
                    }
                    
                }
                
                VStack {
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

                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                                Text("받는 분")
                                    .padding(.bottom, 5)
                                Text("연락처")
                                    .padding(.bottom, 5)
                                Text("주소")
                        }
                        .foregroundColor(.gray)
                        .padding(.trailing, 30)

                        VStack(alignment: .leading) {
                            Text("김멋사")
                                .padding(.bottom, 5)
                            Text("0507-1439-3223")
                                .padding(.bottom, 5)
                            Text("서울특별시 종로구 종로3길 17 D1동 16층, 17층")
                                .lineLimit(2)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)

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
    //                            .fill(.clear)
                            .frame(height: 45)
                    )
                    .padding(.top)
                    
                }
                .padding()
            }
            .padding()
    }
}

struct PaymentAddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentAddressView()
        }
    }
}
