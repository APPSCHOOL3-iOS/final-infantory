//
//  뷰와 관련된 Modifier를 정의하는 공간
//
//
//  Created by 김성훈 on 2023/09/22.
//
import SwiftUI

extension View {
    /// MainView들을 제외한 View 에서 사용가능한 공통 네비게이션 바 수정자
    func infanNavigationBar(title: String) -> some View {
        modifier(InfanNavigationBar(title: title))
    }
    
    /// 앱에서 사용하는 horizontal 기본 패딩 값 (양 옆 20고정)
    func infanHorizontalPadding() -> some View {
        modifier(InfanHorizontalPadding())
    }
}
