//
//  TimerTest.swift
//  Infantory
//
//  Created by 이희찬 on 10/5/23.
//

import SwiftUI

struct TimerView: View {
    @State var remainingTime: Double
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            if remainingTime <= 0 {
                Text("종료됨")
                    .font(.infanFootnote)
                    .padding()
                    .foregroundColor(.gray)
                    
            } else {
                HStack {
                    Image(systemName: "timer")
                    Text("\(InfanDateFormatter.shared.dateToSecondString(from: remainingTime))")
                }
                .frame(width: 110, alignment: .leading)
                .foregroundColor(remainingTime < 3600 ? .infanRed : .infanMain)
                .font(.infanFootnote)
            }
        }
        .padding(.trailing, -10)
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else if remainingTime < 0 {
                remainingTime = 0
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(remainingTime: 3000)
    }
}
