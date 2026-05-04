//
//  MultiQuizView.swift
//  Assignment_3
//
//  Created by Abby on 27/4/2026.
//

import SwiftUI

//displays the quiz screen
struct MultiQuizView: View {
    var flashcards: [Flashcard] //flashcards used for the quiz
    var displayLimit: Int = 3 //amount of cards to display per quiz
    @Binding var score: Int
    
    var onComplete: () -> Void //when the quiz is complete

    @State private var quizCount: Int = 0 //counts the number of quizes that are completed

    var body: some View {
        VStack {
            //get a slice of the flashcards array
            let startIndex = min(flashcards.count, quizCount * displayLimit)
            let endIndex = min(flashcards.count, startIndex + displayLimit)
            let quizCards = Array(flashcards[startIndex..<endIndex])

            //display the array
            QuizView(
                flashcards: quizCards,
                score: $score
            ) {
                print("Quiz \(quizCount) completed")
                
                //checks if the multiple quiz is complete
                let nextStartIndex = (quizCount + 1) * displayLimit
                if (nextStartIndex >= flashcards.count) {
                    onComplete()
                }
                else {
                    //shows the completed quiz before going to the next quiz
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        quizCount += 1
                    }
                }
            }
            .id(quizCount) //re-renders the quiz view when the quizCount changes
        }
    }
}

#Preview {
    MultiQuizPreviewWrapper()
}

struct MultiQuizPreviewWrapper: View {
    let flashcards: [Flashcard]
    let displayLimit: Int
    @State var score: Int = 0

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

        self.displayLimit = Int.random(in: 1...cardCount)
    }

    var body: some View {
        Text("score: \(score)")
        MultiQuizView(
            flashcards: flashcards,
            displayLimit: displayLimit,
            score: $score
        ) {
            print("Multiple Quiz complete")
        }
    }
}
