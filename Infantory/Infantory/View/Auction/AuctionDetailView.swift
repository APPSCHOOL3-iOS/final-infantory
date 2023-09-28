//
//  AuctionDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/25.
//

import SwiftUI

struct AuctionDetailView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                Text("\(userViewModel.user.name)")
                Spacer()
                
                HStack {
                    Image(systemName: "ticket")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                    Text(": \(userViewModel.user.applyTicket?[0].count ?? 0)")
                        .font(.infanBody)
                        .bold()
                }
            }
            Divider()
                .padding([.horizontal, .top])
            
            Text("상품명")
            
            AuctionBuyerView()
            
            LazyVStack(pinnedViews: [.sectionFooters], content: {
                Section(footer: Footer()) {

                    ItemIamgeView()
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .frame(width: CGFloat.screenWidth, height: 300)
                        .padding()
                }
            })
//            Section {
//                HStack {
//                    Text("이런 상품들은 어때요?")
//                    Spacer()
//                }
//                VStack {
//                    AuctionScrollImageView()
//                }
//            }
//            AuctionDetailImageView(auctionProductVIewModel: auctionProductViewModel)
//            AuctionDetailDescriptionView(auctionProductViewModel: auctionProductViewModel)
        }
    }
}

//MARK: - 경매하기 버튼 Footer
struct Footer: View {
    var body: some View {
        VStack {
            Button {
                // 입찰하기 버튼
            } label: {
                Text("입찰 : 10000원")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.infanMain)
                            .frame(width: CGFloat.screenWidth - 20,height: 55)
                    )
            }
            .padding()
            
            .offset(y: -20)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 110)
        .background(
            Rectangle()
                .stroke(lineWidth: 0.1)
                .background(.white)
            
        )
        .offset(x: 0, y: 40)
        Rectangle()
            .frame(height: 40)
            .foregroundColor(.white)
    }
}

struct AuctionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionDetailView(userViewModel: UserViewModel(), auctionProductViewModel: AuctionProductViewModel())
        }
    }
}
