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
    
    @State var questionCardSelected: UUID? = nil
    @State var answerCardSelected: UUID? = nil

    var body: some View {
        VStack {
            ForEach(flashcards) { flashcard in
                Text(flashcard.question)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        questionCardSelected == flashcard.id
                        ? QuizCard.selectedDefault.color
                        : QuizCard.questionDefault.color
                    )
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                questionCardSelected == flashcard.id
                                ? QuizCard.selectedBorder.color
                                : QuizCard.questionBorder.color,
                                lineWidth: 2
                            )
                    )
                    .onTapGesture {
                        if (questionCardSelected == nil) {
                            questionCardSelected = flashcard.id
                        }
                        else if (questionCardSelected == flashcard.id ) {
                            questionCardSelected = nil
                        }
                    }
            }

            Divider()

            ForEach(flashcards) { flashcard in
                Text(flashcard.answer)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        answerCardSelected == flashcard.id
                        ? QuizCard.selectedDefault.color
                        : QuizCard.answerDefault.color
                    )
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                answerCardSelected == flashcard.id
                                ? QuizCard.selectedBorder.color
                                : QuizCard.answerDefault.color,
                                lineWidth: 2
                            )
                    )
                    .onTapGesture {
                        if (answerCardSelected == nil) {
                            answerCardSelected = flashcard.id
                        }
                        else if (answerCardSelected == flashcard.id ) {
                            answerCardSelected = nil
                        }
                    }
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
