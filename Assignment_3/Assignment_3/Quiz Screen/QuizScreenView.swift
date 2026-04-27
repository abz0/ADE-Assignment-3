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
            ForEach(flashcards) { flashcard in
                Text(flashcard.question)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
            }

            Divider()

            ForEach(flashcards) { flashcard in
                Text(flashcard.answer)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.teal.opacity(0.3))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.teal.opacity(0.5), lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    QuizScreenPreviewWrapper()
}

struct QuizScreenPreviewWrapper: View {
    var flashcards: [Flashcard] = []

    init() {
        for i in 1...3 {
            let card = Flashcard(
                topic: "Topic \(i)",
                level: i,
                question: "Question \(i)",
                answer: "Answer \(i)"
            )
            
            flashcards.append(card)
        }
    }
    var body: some View {
        QuizScreenView(
            flashcards: flashcards
        )
    }
}
