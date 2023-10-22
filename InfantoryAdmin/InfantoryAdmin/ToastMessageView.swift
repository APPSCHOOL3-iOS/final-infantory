//
//  ToastMessageView.swift
//  InfantoryAdmin
//
//  Created by 민근의 mac on 10/22/23.
//

import SwiftUI

struct ToastMessageView<Content: View>: View {
    
    let content: Content
    
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            VStack {
                content
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.5), value: isPresented)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
            }
            .padding(.bottom, 30)
        }
    }
}
