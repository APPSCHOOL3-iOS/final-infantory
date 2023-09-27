//
//  Productable.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/22.
//

import Foundation

protocol Productable {
    var id: String { get set }
    var productName: String { get set }
    var productImageURLStrings: [String] { get set }
    var description: String { get set }
    
    // 인플루언서 누구인지, 낙찰자
    var influencerID: String { get set }
    var winningUserID: String? { get set }
    
    // 응모 시작일, 마감일
    var startDate: Date { get set }
    var endDate: Date { get set }
    
    // 지불 가격
    var winningPrice: Int? { get set }
}
