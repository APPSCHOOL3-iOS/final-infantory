//
//  TextAnimateView.swift
//  Infantory
//
//  Created by 민근의 mac on 10/19/23.
//

import SwiftUI

struct TextAnimateView: View, Animatable {
    var value: Double
    
    var animatableData: Double {
       get { value }
       set {
          value = newValue
       }
    }
    
    var body: some View {
        Text("\(Int(value))원")
    }
}
