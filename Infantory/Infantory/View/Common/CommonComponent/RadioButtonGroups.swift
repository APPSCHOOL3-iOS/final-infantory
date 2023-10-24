//
//  RadioButtonGroups.swift
//  Infantory
//
//  Created by 민근의 mac on 10/21/23.
//

import SwiftUI

enum ReportCase: String, CaseIterable {
    case case1 = "거래 금지 물품이에요"
    case case2 = "상품 사진이 부적절해요"
    case case3 = "상품 설명이 부적절해요"
    case case4 = "기타"
}

struct RadioButtonGroups: View {
    let callback: (String) -> Void
    @State var selectedId: String = ""
    
    var body: some View {
        VStack {
            radioCase1
            radioCase2
            radioCase3
            radioCase4
        }
        .horizontalPadding()
    }
    
    var radioCase1: some View {
        RadioButtonField(
            id: ReportCase.case1.rawValue,
            label: ReportCase.case1.rawValue,
            isMarked: selectedId == ReportCase.case1.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioCase2: some View {
        RadioButtonField(
            id: ReportCase.case2.rawValue,
            label: ReportCase.case2.rawValue,
            isMarked: selectedId == ReportCase.case2.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioCase3: some View {
        RadioButtonField(
            id: ReportCase.case3.rawValue,
            label: ReportCase.case3.rawValue,
            isMarked: selectedId == ReportCase.case3.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioCase4: some View {
        RadioButtonField(
            id: ReportCase.case4.rawValue,
            label: ReportCase.case4.rawValue,
            isMarked: selectedId == ReportCase.case4.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String) -> Void
    
    init(
        id: String,
        label: String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 16,
        isMarked: Bool = false,
        callback: @escaping (String) -> Void
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action: {
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .foregroundColor(.infanMain)
                
                Text(label)
                    .font(Font.system(size: textSize))
                
                Spacer()
                
            }
            .foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}
