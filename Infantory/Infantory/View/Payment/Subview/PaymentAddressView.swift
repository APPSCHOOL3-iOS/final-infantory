//
//  PaymentAddressView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/20.
//

import SwiftUI

struct PaymentAddressView: View {
    let paymentStore: PaymentStore
    @Binding var paymentInfo: PaymentInfo
    @State var directMessage: String = ""
    
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
            PaymentAddressView(paymentStore: PaymentStore(user: User.dummyUser,
                                                          product: AuctionProduct.dummyProduct),
                               paymentInfo: .constant(PaymentInfo(userId: "",
                                                                  address: Address.init(address: "",
                                                                                        zonecode: "",
                                                                                        addressDetail: ""),
                                                                  deliveryRequest: .door,
                                                                  deliveryCost: 3000,
                                                                  paymentMethod: .accountTransfer))
            )
        }
    }
}

extension PaymentAddressView {
    
    var productInfo: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: paymentStore.product.productImageURLStrings[0])) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                } placeholder: {
                    ProgressView()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .frame(width: 100, height: 100)
                )
                .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(paymentStore.product.influencerID)
                        .fontWeight(.semibold)
                    
                    Text(paymentStore.product.productName)
                    
                    Text(paymentStore.product.description)
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
    
    var addressView: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                Text("배송 주소")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                NavigationLink {
                    PaymentAddressWebView(paymentInfo: $paymentInfo)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("주소 변경")
                        .font(.footnote)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: 70, height: 25)
                        )
                }
                .buttonStyle(.plain)
            }
            
            ForEach(PaymentAddress.allCases, id: \.rawValue) { item in
                HStack {
                    Text(item.title)
                        .frame(width: 50, alignment: .leading)
                    Text(item.content(paymentStore: paymentStore))
                }
            }
            
        }
    }
    
    var deliveryRequestView: some View {
        VStack(alignment: .leading) {
            Text("배송 요청사항")
                .font(.infanFootnote)
                .padding(.bottom, -7)
            
            Button {
                
            } label: {
                Picker("Choose a message", selection: $paymentInfo.deliveryRequest) {
                    Text("부재 시 문 앞에 놓아주세요").tag(PaymentInfo.DeliveryMessages.door)
                    Text("부재 시 경비실에 맡겨 주세요").tag(PaymentInfo.DeliveryMessages.securityOffice)
                    Text("배송 전 연락 바랍니다").tag(PaymentInfo.DeliveryMessages.call)
                    Text("직접 입력").tag(PaymentInfo.DeliveryMessages.directMessage)
                }
                .pickerStyle(.menu)
                .accentColor(.infanDarkGray)
                
                if paymentInfo.deliveryRequest == PaymentInfo.DeliveryMessages.directMessage {
                    TextField("메시지를 입력해 주세요", text: $directMessage)
                        .padding(.leading, -20)
                }
            }
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.infanLightGray)
                    .frame(height: 43)
            )
            .padding(.top)
        }
    }
    
    var directMessageView: some View {
        TextField("메시지를 입력해 주세요", text: $directMessage)
    }
}
