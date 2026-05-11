//
//  GameView.swift
//  Assignment_3
//
//  Created by Elissa on 28/4/2026.
//


import SwiftUI

struct GameView: View {
    @State var flashcards: [Flashcard]
    @State private var currentScore: Int = 0
    @StateObject var viewModel = TopicViewModel()


    @State private var goToEndScreen = false

    var body: some View {
        VStack {
            HStack {
                CountdownView(startSeconds: 60) {
                    print("Countdown finish")
                    goToEndScreen = true
                }
                
                Spacer()
                
                VStack {
                    Text("Score:")
                    Text(String(currentScore))
                }
                .padding()
                .font(.system(size: 20))

                Spacer()
                
            }
            
            Spacer()

            MultiQuizView(
                flashcards: flashcards,
                score: $currentScore
            ) {
                print("Multiple Quiz complete")
                goToEndScreen = true
            }

            Spacer()
        }
        .navigationDestination(isPresented: $goToEndScreen) {
            EndScreenView(
                gameScore: currentScore
            )
        }
        
    }
}

#Preview {
    GamePreviewWrapper()
}

struct GamePreviewWrapper: View {
    let flashcards: [Flashcard]
    let highScore: Int

    init() {
        let cardCount: Int = 5
        
        self.flashcards = (1...cardCount).map {
            Flashcard(
                topic: "Topic \($0)",
                level: $0,
                question: "Question \($0)",
                answer: "Answer \($0)"
            )
        }

        self.highScore = Int.random(in: 1...999)
    }

    var body: some View {
        GameView(
            flashcards: flashcards
        )
    }
}
