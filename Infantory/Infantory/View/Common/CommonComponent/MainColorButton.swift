//
//  InfanMainButton.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/06.
//
import SwiftUI

struct MainColorButton: View {
    
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.infanMain)
                .cornerRadius(8)
                .overlay {
                    Text("\(text)")
                        .foregroundColor(.white)
                        .font(.infanHeadline)
                        .padding()
                }
                .frame(width: .screenWidth - 40, height: 54)
        }
    }
}
