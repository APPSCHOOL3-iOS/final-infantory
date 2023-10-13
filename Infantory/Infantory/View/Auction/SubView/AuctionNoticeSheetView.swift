//
//  AuctionNoticeView.swift
//  Infantory
//
//  Created by 변상필 on 10/10/23.
//

import SwiftUI

struct AuctionNoticeSheetView: View {
    @ObservedObject var auctionViewModel: AuctionStore
    
    @Binding var isShowingAuctionNoticeSheet: Bool

    @EnvironmentObject var loginStore: LoginStore
    
    @State private var isShowingNoticeChecked: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.infanLightGray)
                    .opacity(0.3)
                    .frame(height: 150)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("유의사항")
                        .font(.infanHeadlineBold)
                        .padding(.bottom, 7)
                    
                    Text("- 최고 입찰자는 중복 입찰이 불가합니다.")
                    Text("- 최고 입찰자는 입찰을 취소 할 수 없습니다.")
                    Text("- 최고 낙찰자임에도 불구하고 12시간 내 결제 진행을 하지 않을실 경우, 2순위 낙찰자에게 구매 권한이 넘어갑니다.")
                    Text("- 결제 미진행 시 한달간 경매 참여가 불가능합니다.")
                }
                .font(.infanFootnote)
            }
            HStack {
                Button(action: {
                    isShowingNoticeChecked.toggle()
                }, label: {
                    HStack {
                        if isShowingNoticeChecked == false {
                            Text("\(Image(systemName: "square"))")
                        } else {
                            Text("\(Image(systemName: "checkmark.square.fill"))")
                        }
                        Text("다시 보지않기")
                    }
                })
                Spacer()
            }
            .foregroundColor(isShowingNoticeChecked ? .infanGray : .infanMain)
            .font(.infanFootnoteBold)
            .padding(.bottom)
            
            MainColorButton(text: "확인") {
                if isShowingNoticeChecked {
                    loginStore.warning = false
                    isShowingAuctionNoticeSheet = false
                }
                print("isShowingAuctionNoticeSheet ----\(isShowingAuctionNoticeSheet)")
                
            }
        }
        .horizontalPadding()
    }
}

struct AuctionNoticeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionNoticeSheetView(auctionViewModel: AuctionStore(product: AuctionProduct.dummyProduct), isShowingAuctionNoticeSheet: .constant(true))
    }
}
