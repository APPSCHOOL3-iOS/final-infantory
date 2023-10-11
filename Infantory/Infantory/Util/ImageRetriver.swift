//
//  CacheImageLoader.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/10.
//

import UIKit

class ImageRetriver {
    
    func fetch(_ imgUrl: String) async throws -> Data {
        guard let url = URL(string: imgUrl) else {
            throw RetriverError.invalidUrl
        }
    
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }    
}

extension ImageRetriver {
    enum RetriverError: Error {
        case invalidUrl
    }
}
