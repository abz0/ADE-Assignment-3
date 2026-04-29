//
//  QuizScreenView.swift
//  Assignment_3
//
//  Created by Abby on 27/4/2026.
//

import SwiftUI

//displays the quiz screen
struct QuizScreenView: View {
    var flashcards: [Flashcard] //flashcards used for the quiz
    
    var body: some View {
        VStack {
            QuizView(flashcards: flashcards) {
                print("Quiz completed")
            }
        }
    }
}

#Preview {
    QuizScreenPreviewWrapper()
}

struct QuizScreenPreviewWrapper: View {
    let flashcards: [Flashcard] = (1...3).map {
        Flashcard(
            topic: "Topic \($0)",
            level: $0,
            question: "Question \($0)",
            answer: "Answer \($0)"
        )
    }

    var body: some View {
        QuizScreenView(flashcards: flashcards)
    }
}
