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
            Label("\(InfanDateFormatter.shared.dateToSecondString(from: remainingTime))",
                  systemImage: "timer")
            .foregroundColor(.infanMain)
            .font(.infanFootnote)
        }
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(remainingTime: 10000.0)
    }
}

/*
 타이머
 줄어드는 시간을 표시하기
 -> 
 
 */
