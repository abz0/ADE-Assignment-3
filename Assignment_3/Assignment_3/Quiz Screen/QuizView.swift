//
//  QuizView.swift
//  Assignment_3
//
//  Created by Abby on 29/4/2026.
//

import SwiftUI

//displays the quiz screen
struct QuizView: View {
    var flashcards: [Flashcard] //flashcards used for the quiz
    var isOrderRandom: Bool = true //whether the order of the flashcards are randomised
    @Binding var score: Int //gets the scores of the cards
    
    //order of the cards
    @State var questionCardOrder: [Int] = [] //stores the order of the question cards by index
    @State var answerCardOrder: [Int] = [] //stores the order of the answer cards by index

    //list of the card states
    @State var questionCardStates: [UUID: CardState] = [:]
    @State var answerCardStates: [UUID: CardState] = [:]

    //check if a card is selected
    @State var questionCardSelected: UUID? = nil
    @State var answerCardSelected: UUID? = nil
    
    @State var correctCardsCount: Int = 0 //counts the correct paired cards
    
    var onComplete: () -> Void //when the quiz is complete

    var body: some View {
        VStack {
            //question cards
            VStack {
                ForEach(questionCardOrder, id: \.self) { index in
                    let flashcard = flashcards[index] //gets the flash card
                    
                    CardView(
                        text: flashcard.question,
                        colorMain: getCardColor(
                            cardState: questionCardStates[flashcard.id] ?? .normal,
                            cardRole: .question
                        ),
                        colorBorder: getCardBorder(
                            cardState: questionCardStates[flashcard.id] ?? .normal,
                            cardRole: .question
                        )
                    ) {
                        //when the card is tapped
                        
                        //guards against correct and wrong cards
                        if (questionCardStates[flashcard.id] == .correct ||
                            questionCardStates[flashcard.id] == .wrong) {
                            return
                        }

                        //change the state selection of the cards
                        if (questionCardSelected == nil) {
                            questionCardSelected = flashcard.id
                            questionCardStates[flashcard.id] = .selected
                            
                            checkMatch()
                        } else if (questionCardSelected == flashcard.id) {
                            questionCardStates[flashcard.id] = .normal
                            questionCardSelected = nil
                        }
                   }
                }
            }
            .padding(25)

            Divider()
                .frame(height: 1)
                .background(Color.gray)

            //answer cards
            VStack {
                ForEach(answerCardOrder, id: \.self) { index in
                    let flashcard = flashcards[index] //gets the flash card
                    
                    CardView(
                        text: flashcard.answer,
                        colorMain: getCardColor(
                            cardState: answerCardStates[flashcard.id] ?? .normal,
                            cardRole: .answer
                        ),
                        colorBorder: getCardBorder(
                            cardState: answerCardStates[flashcard.id] ?? .normal,
                            cardRole: .answer
                        )
                    ) {
                        //when the card is tapped
                        
                        //guards against correct and wrong cards
                        if (answerCardStates[flashcard.id] == .correct ||
                            answerCardStates[flashcard.id] == .wrong) {
                            return
                        }

                        //change the state selection of the cards
                        if (answerCardSelected == nil) {
                            answerCardSelected = flashcard.id
                            answerCardStates[flashcard.id] = .selected
                            
                            checkMatch()
                        } else if (answerCardSelected == flashcard.id) {
                            answerCardStates[flashcard.id] = .normal
                            answerCardSelected = nil
                        }
                   }
                }
            }
            .onChange(of: correctCardsCount) {
                if (correctCardsCount == flashcards.count) {
                    onComplete()
                }
            }
            .padding(25)
        }
        .onAppear() {
            setCardOrders()
        }
    }
    
    //sets the order of the question and answere cards
    func setCardOrders() {
        //gets the index of the flashcards
        questionCardOrder = Array(0..<flashcards.count)
        answerCardOrder = Array(0..<flashcards.count)
        
        //guards against false isOrderRandom
        if (!isOrderRandom) { return }
        
        //randomise the order
        questionCardOrder.shuffle()
        answerCardOrder.shuffle()
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
    
    //checks whether the question and answer cards match
    func checkMatch() {
        //guards against nil card selections
        guard let q = questionCardSelected,
              let a = answerCardSelected
        else {
            return
        }
        
        //checks the match
        if (q == a) {
            //adds the score
            if let flashcard = flashcards.first(where: { $0.id == q }) {
                score += flashcard.level
            }
            
            //show the correct card state
            questionCardStates[q] = .correct
            answerCardStates[a] = .correct
            
            correctCardsCount += 1
        }
        else {
            //subtract the score
            score -= 3
            
            //show the wrong card state
            questionCardStates[q] = .wrong
            answerCardStates[a] = .wrong
            
            //waits a while before going to normal
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                questionCardStates[q] = .normal
                answerCardStates[a] = .normal
            }
        }

        questionCardSelected = nil
        answerCardSelected = nil
    }
}

#Preview {
    QuizPreviewWrapper()
}

struct QuizPreviewWrapper: View {
    let flashcards: [Flashcard] = (1...3).map {
        Flashcard(
            topic: "Topic \($0)",
            level: $0,
            question: "Question \($0)",
            answer: "Answer \($0)"
        )
    }
    @State var score: Int = 0

    var body: some View {
        Text("score: \(score)")
        QuizView(
            flashcards: flashcards,
            score: $score
        ) {
            print("Quiz completed")
        }
    }
}
