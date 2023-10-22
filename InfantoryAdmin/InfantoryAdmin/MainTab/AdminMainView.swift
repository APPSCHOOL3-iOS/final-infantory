//
//  AdminMainView.swift
//  InfantoryAdmin
//
//  Created by 변상필 on 10/19/23.
//

import SwiftUI

// 관리자 UID 같은 걸로 접속할 수 있게
/*
 1. 로그인 화면이 떠서 관리자 인증
 2. 홈 탭뷰로 메뉴 구성
 3.
 */

struct AdminMainView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            ApplyLotteryView()
                .tabItem {
                    Text(AdminFeature.applyLottery.title)
                }
                .tag(0)
            PaymentProductView()
                .tabItem {
                    Text(AdminFeature.paymentProduct.title)
                }
                .tag(1)
            InfluencerView()
                .tabItem {
                    Text(AdminFeature.influencer.title)
                }
                .tag(2)
            ReportView()
                .tabItem {
                    Text(AdminFeature.report.title)
                }
                .tag(3)
        }
    }
}

struct AdminMainView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMainView()
    }
}

enum AdminFeature: Int, CaseIterable {
    case applyLottery
    case paymentProduct
    case influencer
    case report
    
    var title: String {
        switch self {
        case .applyLottery: return "응모 추첨"
        case .paymentProduct: return "결제 상품 관리"
        case .influencer: return "인플루언서 관리"
        case .report: return "신고"
        }
    }
}
