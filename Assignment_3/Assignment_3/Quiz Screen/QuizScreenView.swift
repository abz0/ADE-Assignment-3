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
    
    //list of the card states
    @State var questionCardStates: [UUID: CardState] = [:]
    @State var answerCardStates: [UUID: CardState] = [:]

    //check if a card is selected
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
                        getCardColor(
                            cardState: questionCardStates[flashcard.id] ?? .normal,
                            cardRole: .question
                        )
                    )
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                getCardBorder(
                                    cardState: questionCardStates[flashcard.id] ?? .normal,
                                    cardRole: .question
                                ),
                                lineWidth: 2
                            )
                    )
                    .onTapGesture {
                        if (questionCardSelected == nil) {
                            questionCardSelected = flashcard.id
                            questionCardStates[questionCardSelected!] = .selected
                        }
                        else if (questionCardSelected == flashcard.id) {
                            questionCardStates[questionCardSelected!] = .normal
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
                        getCardColor(
                            cardState: answerCardStates[flashcard.id] ?? .normal,
                            cardRole: .answer
                        )
                    )
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                getCardColor(
                                    cardState: answerCardStates[flashcard.id] ?? .normal,
                                    cardRole: .answer
                                ),
                                lineWidth: 2
                            )
                    )
                    .onTapGesture {
                        if (answerCardSelected == nil) {
                            answerCardSelected = flashcard.id
                            answerCardStates[answerCardSelected!] = .selected
                        }
                        else if (answerCardSelected == flashcard.id) {
                            answerCardStates[answerCardSelected!] = .normal
                            answerCardSelected = nil
                        }
                    }
            }
        }
    }
    
    //gets the color of the card
    func getCardColor(cardState: CardState, cardRole: CardRole) -> Color {
        switch (cardState) {
        case .normal:
            return cardRole == .question ? Color.gray.opacity(0.3) : Color.teal.opacity(0.3)
        case .selected:
            return Color.yellow.opacity(0.5)
        case .correct:
            return Color.green.opacity(0.3)
        case .wrong:
            return Color.red.opacity(0.3)
        }
    }
    
    //gets the color of the card
    func getCardBorder(cardState: CardState, cardRole: CardRole) -> Color {
        switch (cardState) {
        case .normal:
            return cardRole == .question ? Color.gray.opacity(0.5) : Color.teal.opacity(0.5)
        case .selected:
            return Color.yellow.opacity(0.7)
        case .correct:
            return Color.green.opacity(0.5)
        case .wrong:
            return Color.red.opacity(0.5)
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
