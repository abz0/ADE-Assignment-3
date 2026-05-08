//
//  GameView.swift
//  Assignment_3
//
//  Created by Elissa Miraziz (School) on 28/4/2026.
//


import SwiftUI

struct GameView: View {
    @State var topic: Topic
    @State var flashcards: [Flashcard] = [Flashcard(
        topic: "TestTopic",
        level: 1,
        question: "TestQuestionA",
        answer: "TestAnswerA"
     ),
     Flashcard(
          topic: "TestTopic",
          level: 1,
          question: "TestQuestionB",
          answer: "TestAnswerB"
      ),
     Flashcard(
          topic: "TestTopic",
          level: 1,
          question: "TestQuestionC",
          answer: "TestAnswerC"
      )]
    @State var score: Int = 0
/*
    @State private var flashcardsTest: [Flashcard] =
        [Flashcard(
            topic: "TestTopic",
            level: 1,
            question: "TestQuestion1",
            answer: "TestAnswer1"
         ),
         Flashcard(
              topic: "TestTopic",
              level: 1,
              question: "TestQuestion2",
              answer: "TestAnswer2"
          ),
         Flashcard(
              topic: "TestTopic",
              level: 1,
              question: "TestQuestion3",
              answer: "TestAnswer3"
          )
                                                      

    
    ]*/

    @State private var goToEndScreen = false

    var body: some View {
        VStack {
            HStack {
                CountdownView(startSeconds: 10) {
                    print("Countdown finish")
                    goToEndScreen = true
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .padding()
                    .font(.system(size: 25))
            }
            
            Spacer()

            MultiQuizView(
                flashcards: flashcards, //topic.flashcards,
                score: $score
            ) {
                print("Multiple Quiz complete")
                goToEndScreen = true
            }

            Spacer()
        }
        .navigationDestination(isPresented: $goToEndScreen) {
            //works if the GameView is in a navigation stack
            EndScreenView(score: score)
        }
        .onAppear {
            //loadFlashcards()
        }
    }
    
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                topic.flashcards = decodedCards
            }
        }
    }
}

#Preview {
    GameView(topic: Topic(topicName: "New Topic", highScore: 100, flashcards: [Flashcard(
        topic: "TestTopic",
        level: 1,
        question: "TestQuestion1",
        answer: "TestAnswer1"
    )]
                         ), flashcards: [Flashcard(
                            topic: "TestTopic",
                            level: 1,
                            question: "TestQuestionA",
                            answer: "TestAnswerA"
                         ),
                         Flashcard(
                              topic: "TestTopic",
                              level: 1,
                              question: "TestQuestionB",
                              answer: "TestAnswerB"
                          ),
                         Flashcard(
                              topic: "TestTopic",
                              level: 1,
                              question: "TestQuestionC",
                              answer: "TestAnswerC"
                          )])
}
