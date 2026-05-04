//
//  CountdownView.swift
//  Assignment_3
//
//  Created by Abby on 3/5/2026.
//

import SwiftUI
import Combine


struct CountdownView: View {
    var startSeconds: Int = 60
    
    @State private var countdownInSeconds = 0
    @State private var isCountingDown = false
    
    var body: some View {
        VStack {
            Text("Countdown: \(countdownInSeconds)")
                .padding()

            Button(action: {
                isCountingDown.toggle()

                if isCountingDown {
                    startCountDown()
                } else {
                    resetTimer()
                }
            }) {
                Text(isCountingDown ? "Stop" : "Start")
                    .padding()
            }
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: { _ in
            if isCountingDown {
                onCountDown()
            }
        })
        .onAppear {
            resetTimer()
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
        }
    }
}

#Preview {
    CountdownView()
}
