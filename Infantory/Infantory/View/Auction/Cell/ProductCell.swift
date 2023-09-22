//
//  ProductCell.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/22.
//

import SwiftUI

struct ProductCell: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                Text("오킹")
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            }
            .padding([.horizontal, .top])
            Button {
                
            } label: {
                HStack {
                    Image("Shose1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 160)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Hot")
                                .font(.infanFootnote)
                                .frame(width: 40, height: 20)
                                .foregroundColor(.infanDarkGray)
                                .background(Color.infanRed)
                                .cornerRadius(10)
                            Text("New")
                                .font(.infanFootnote)
                                .frame(width: 40, height: 20)
                                .foregroundColor(.infanDarkGray)
                                .background(Color.infanGreen)
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text("상품명: ")
                                .font(.infanTitle2)
                                .foregroundColor(.infanDarkGray)
                                .padding(.bottom)
                            Text("남은시간: ")
                                .font(.infanBody)
                                .foregroundColor(.infanDarkGray)
                            Text("현재 입찰가: ")
                                .font(.infanBody)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell()
    }
}
