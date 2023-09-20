//
//  ImageCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/20.
//

import SwiftUI

struct ImageCell: View {
    var body: some View {
        HStack {
            Section("착장사진") {
                Image("Influencer1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .cornerRadius(10)
            }
        }
    }
}

struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        ImageCell()
    }
}
