//
//  CountdownView.swift
//  Assignment_3
//
//  Created by Abby on 3/5/2026.
//

import SwiftUI
import Combine

//view of the countdown
struct CountdownView: View {
    var startSeconds: Int = 60

    var onFinish: () -> Void //when the countdown is finished

    @State private var countdownInSeconds: Int = 0
    @State private var isCountingDown: Bool = false
    
    var body: some View {
        VStack {
            Text("Countdown:")
            Text(String(countdownInSeconds))
        }
        .padding()
        .font(.system(size: 20))
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: { _ in
            if isCountingDown {
                onCountDown()
            }
        })
        .onAppear {
            resetTimer()
            startCountDown()
        }
    }
    
    //begins the countdown
    func startCountDown() {
        isCountingDown = true
    }
    
    //resets the timer state
    func resetTimer() {
        isCountingDown = false
        countdownInSeconds = startSeconds
    }
    
    //decrements the countdown timer by one second
    func onCountDown() {
        if countdownInSeconds > 0 {
            countdownInSeconds -= 1
        } else {
            isCountingDown = false
            onFinish()
        }
    }
}

#Preview {
    CountdownView() {
        print("Countdown finish")
    }
}
