//
//  EndScreen.swift
//  Assignment_3
//
//  Created by Abby on 4/5/2026.
//

import SwiftUI

struct EndScreenView: View {
    var gameScore: Int //score from the game
    var highScore: Int //high score from the game
    @State private var streak: Int = 0 //winning game streaks
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Quiz Finished!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your Score: \(gameScore)")
                .font(.headline)
                .foregroundStyle(gameScore > highScore ? .green : .black)

            Text("Study Streak: \(streak) day(s)")
                .font(.headline)
                .foregroundStyle(.orange)
            
            Text("Great job finishing today’s quiz! Keep your streak going by studying again tomorrow.")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            NavigationLink(destination: TitleScreenView()) {
                Text("Go back to Title Screen")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow.opacity(0.5))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                    )
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .onAppear {
            StreakManager.shared.recordStudySession()
            streak = StreakManager.shared.getCurrentStreak()
        }
    }
}

#Preview {
    EndScreenPreviewWrapper()
}

struct EndScreenPreviewWrapper: View {
    let gameScore: Int = Int.random(in: 1...999)
    let highScore: Int = Int.random(in: 1...999)

    var body: some View {
        Text("highScore: \(highScore)")
        EndScreenView(
            gameScore: gameScore,
            highScore: highScore
        )
    }
}
