//
//  AuctionDetailView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/09/25.
//

import SwiftUI
import ExpandableText

struct AuctionDetailView: View {
    
    @EnvironmentObject var loginStore: LoginStore
    @ObservedObject var auctionProductViewModel: AuctionProductViewModel
    @StateObject var auctionViewModel: AuctionViewModel = AuctionViewModel()
    
    let sampleText = "이 신발을 신으면, 당신은 상필갓처럼 도도한 패션 감각을 뽐낼 수 있게 됩니다. 상필갓은 그의 스타일과 패션 감각으로 많은 사람들에게 인정받는 스타일 아이콘이니, 그와 같은 느낌의 스타일을 갖추게 될 것입니다. 그렇다고 해서 당신이 상필갓의 스타일을 100% 복제할 수 있을 거라는 뜻은 아닙니다. 물론, 상필갓만의 독특하고 돋보이는 스타일을 그대로 따라 할 수는 없겠지만, 이 신발 덕분에 그에 준하는 스타일리시한 느낌을 낼 수는 있을 것입니다. 다시 말해, 이 신발이 당신에게 상필갓과 같은 세련된 패션 센스의 묘미를 부여해줄 것이라는 점에서는 확실합니다. 때문에, 이 신발을 선택한다면 당신의 스타일도 한층 업그레이드 될 것이며, 사람들의 시선도 자연스럽게 당신에게 집중될 것입니다."
    @State var timer: String = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                Divider()
                
                AuctionBuyerView(auctionViewModel: auctionViewModel)
                
                ProfileRowView()
                
                AuctionItemImage()
                    .frame(width: .screenWidth - 40, height: .screenWidth - 40)
                    .cornerRadius(8)
                
                productInfo             
            }
            Footer(auctionViewModel: AuctionViewModel())
        }
    }
}

struct AuctionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuctionDetailView(userViewModel: UserViewModel(), auctionProductViewModel: AuctionProductViewModel())
        }
    }
}

struct Footer: View {
    @ObservedObject var auctionViewModel: AuctionViewModel
    
    @State private var isShowingAuctionBidSheet: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isShowingAuctionBidSheet.toggle()
            } label: {
                Text("입찰 \(auctionViewModel.biddingInfos.last?.biddingPrice ?? 0) 원")
                    .font(.infanHeadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.infanMain)
                            .frame(width: CGFloat.screenWidth - 40, height: 54)
                    )
            }
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
        .sheet(isPresented: $isShowingAuctionBidSheet, content: {
            AuctionBidSheetView(auctionViewModel: auctionViewModel, isShowingAuctionBidSheet: $isShowingAuctionBidSheet)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        })
    }
}

extension AuctionDetailView {
    var productInfo: some View {
        VStack {
            HStack {
                Text("멋쟁이 신발")
                    .font(.infanTitle2)
                Spacer()
                // 남은 시간
                TimerView(remainingTime: auctionViewModel.remainingTime)
            }
            .padding(.top)
            .infanHorizontalPadding()
            
            // 제품 설명
            ExpandableText(text: sampleText)
                .font(.body)//optional
                .foregroundColor(.primary)//optional
                .lineLimit(3)//optional
                .expandButton(TextSet(text: "... 더보기", font: .body, color: .blue))//optional
                .collapseButton(TextSet(text: "간략히", font: .body, color: .blue))//optional
                .expandAnimation(.easeOut)//optional
                .padding(.horizontal, 24)//optional
                .padding(.bottom, 100)
        }
    }
}
