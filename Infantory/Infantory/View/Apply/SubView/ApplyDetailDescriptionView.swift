//
//  ApplyDetailDescriptionView.swift
//  Infantory
//
//  Created by 윤경환 on 2023/09/26.
//

import SwiftUI

struct ApplyDetailDescriptionView: View {
    
    @State private var isShowingApplySheet: Bool = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                isShowingApplySheet = true
            }, label: {
                HStack {
                    Image("applyTicket1")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .aspectRatio(contentMode: .fit)
                    Text("응모하기")
                }
                .frame(width: .screenWidth * 0.8, height: .screenHeight * 0.03)
                .font(.infanTitle)
                .padding()
                .foregroundColor(.white)
                .background(Color.infanMain)
                .cornerRadius(15)
            })
        }
        
    }
}

struct ApplyDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailDescriptionView()
    }
}
