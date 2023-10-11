//
//  CachedImage.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/10.
//

import SwiftUI

struct CachedImage<Content: View>: View {
    
    @StateObject private var manager = CachedImageManager()
    let url: String
    let animation: Animation?
    let transition: AnyTransition
    let content: (AsyncImagePhase) -> Content
    
    init(url: String,
         animation: Animation? = nil,
         transition: AnyTransition = .identity,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.animation = animation
        self.transition = transition
        self.content = content
    }
    
    var body: some View {
        ZStack {
            switch manager.currentState {
            case .loading:
                content(.empty)
                    .transition(transition)
            case .success(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                        .transition(transition)
                } else {
                    content(.failure(CachedImageError.inavlidData))
                        .transition(transition)
                }
            case .failed(let error):
                content(.failure(error))
                    .transition(transition)
            default:
                content(.empty)
                    .transition(transition)

            }
        }
        .animation(animation, value: manager.currentState)
        .task {
            await manager.load(url)
        }
    }

}

extension CachedImage {
    enum CachedImageError: Error {
        case inavlidData
    }
}
