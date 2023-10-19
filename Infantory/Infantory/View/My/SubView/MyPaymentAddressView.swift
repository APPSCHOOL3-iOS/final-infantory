////
////  MyPaymentAddressView.swift
////  Infantory
////
////  Created by 봉주헌 on 2023/10/19.
////
//
//import SwiftUI
//
//struct MyPaymentAddressView: View {
//    let paymentStore: PaymentStore
//    @Binding var paymentInfo: PaymentInfo
//    @State var directMessage: String = ""
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            productInfo
//            
//            addressView
//                .padding(.top)
//            
//        }
//        .padding()
//    }
//}
//
//struct MyPaymentAddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            PaymentAddressView(paymentStore: PaymentStore(user: User.dummyUser,
//                                                          product: AuctionProduct.dummyProduct),
//                               paymentInfo: .constant(PaymentInfo(userId: "",
//                                                                  address: Address.init(address: "",
//                                                                                        zonecode: "",
//                                                                                        addressDetail: ""),
//                                                                  deliveryRequest: .door,
//                                                                  deliveryCost: 3000,
//                                                                  paymentMethod: .accountTransfer))
//            )
//        }
//    }
//}
//extension PaymentAddressView {
//    
//    var productInfo: some View {
//        VStack {
//            HStack(alignment: .top) {
//                CachedImage(url: paymentStore.product.productImageURLStrings[0]) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 90, height: 90)
//                            .cornerRadius(20)
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .frame(width: 100, height: 100)
//                            
//                    case .failure:
//                        Image(systemName: "xmark")
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 40, height: 40)
//                            .cornerRadius(20)
//                        
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(lineWidth: 1)
//                        .frame(width: 100, height: 100)
//                )
//                .padding(.trailing)
//                
//                VStack(alignment: .leading) {
//                    Text(paymentStore.user.nickName)
//                        .fontWeight(.semibold)
//                    
//                    Text(paymentStore.product.productName)
//                    
//                    Text(paymentStore.product.description)
//                        .foregroundColor(.gray)
//                }
//                
//            }
//        }
//    }
//    
//    var addressView: some View {
//        VStack(alignment: .leading, spacing: 7) {
//            HStack {
//                Text("배송 주소")
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                
//                Spacer()
//                
//                NavigationLink {
//                    PaymentAddressWebView(paymentInfo: $paymentInfo)
//                        .navigationBarBackButtonHidden(true)
//                } label: {
//                    Text("주소 변경")
//                        .font(.footnote)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.gray, lineWidth: 1)
//                                .frame(width: 70, height: 25)
//                        )
//                }
//                .buttonStyle(.plain)
//            }
//            
//            ForEach(PaymentAddress.allCases, id: \.rawValue) { item in
//                HStack {
//                    Text(item.title)
//                        .frame(width: 50, alignment: .leading)
//                    Text(item.content(paymentStore: paymentStore))
//                }
//            }
//            
//        }
//    }
