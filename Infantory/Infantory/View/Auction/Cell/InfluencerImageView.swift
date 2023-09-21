//
//  ImageCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/20.
//

import SwiftUI

struct InfluencerImageView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Image("Influencer1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .cornerRadius(10)
            }
        }
    }
}
struct ItemIamgeView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Image("Shose1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .cornerRadius(10)
            }
        }

    }
}
struct ItemIamgeView_Previews: PreviewProvider {
    static var previews: some View {
        ItemIamgeView()
    }
}

struct InfluencerImageView_Previews: PreviewProvider {
    static var previews: some View {
        InfluencerImageView()
    }
}
