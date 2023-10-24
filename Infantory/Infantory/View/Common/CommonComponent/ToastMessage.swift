//
//  ToastMessage.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/27.
//

import SwiftUI

struct ToastMessage<Content: View>: View {
    let content: Content
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            VStack {
                content
                    .padding()
                    .background(Color.infanMain.opacity(0.7))
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
