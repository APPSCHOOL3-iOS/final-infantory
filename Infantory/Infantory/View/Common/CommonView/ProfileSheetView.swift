import SwiftUI

struct ProfileSheetView: View {
    let sheetOptions: [(imageName: String, title: String)] = [
        ("bookmark", "저장"),
        ("qrcode.viewfinder", "QR 코드"),
        ("", "이 계정 정보"),
        ("", "숨기기"),
        ("", "신고")
    ]

    var body: some View {
        VStack {
            ForEach(sheetOptions, id: \.title) { item in
                OptionRowView(option: item)
            }
        }
    }
}

struct OptionRowView: View {
    let option: (imageName: String, title: String)

    var body: some View {
        VStack {
            HStack {
                Image(systemName: option.imageName)
                
                Text(option.title)
            }
        }
    }
}
