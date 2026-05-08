//
//  EndScreen.swift
//  Assignment_3
//
//  Created by Abby on 4/5/2026.
//

import SwiftUI

struct EndScreenView: View {
    var score: Int
    @State private var streak: Int = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Quiz Finished!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your Score: \(score)")
                .font(.headline)
            
            Text("Study Streak: \(streak) day(s)")
                .font(.headline)
                .foregroundStyle(.orange)
            
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
            NotificationManager.shared.sendQuizFinishedNotification()
        }
        .padding()
    }
}

#Preview {
    EndScreenPreviewWrapper()
}

struct EndScreenPreviewWrapper: View {
    let score: Int = Int.random(in: 1...999)

    var body: some View {
        EndScreenView(score: score)
    }
}
