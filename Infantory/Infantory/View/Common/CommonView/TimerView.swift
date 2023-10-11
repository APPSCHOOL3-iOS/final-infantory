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
        VStack {
            if remainingTime <= 0 {
                Text("\(Image(systemName: "timer")) 입찰 마감")
                    .font(.infanFootnote)
                    .foregroundColor(.gray)
            } else {
                Label("\(InfanDateFormatter.shared.dateToSecondString(from: remainingTime))",
                      systemImage: "timer")
                .foregroundColor(remainingTime < 3600 ? .infanRed : .infanMain)
                .font(.infanFootnote)
            }
        }
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else if remainingTime < 0 {
                remainingTime = 0
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(remainingTime: 0)
    }
}
