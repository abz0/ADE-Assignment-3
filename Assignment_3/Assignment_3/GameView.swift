//
//  GameView.swift
//  Assignment_3
//
//  Created by Elissa Miraziz (School) on 28/4/2026.
//


import SwiftUI

struct GameView: View {
    //@State var topic: Topic
    @State var flashcards: [Flashcard] /*= [Flashcard(
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
      )]*/

    @State var highScore: Int = 0
    @State private var currentScore: Int = 0
    
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
                    saveHighScore()
                    goToEndScreen = true
                }
                
                Spacer()
                
                Text("Score: \(currentScore)")
                    .padding()
                    .font(.system(size: 25))
                
                Spacer()
                
                Text("High Score: \(highScore)")
                    .padding()
                    .font(.system(size: 25))
            }
            
            Spacer()

            MultiQuizView(
                flashcards: flashcards, //topic.flashcards,
                score: $currentScore
            ) {
                print("Multiple Quiz complete")
                saveHighScore()
                goToEndScreen = true
            }

            Spacer()
        }
        .navigationDestination(isPresented: $goToEndScreen) {
            //works if the GameView is in a navigation stack
            EndScreenView(
                gameScore: currentScore,
                highScore: highScore
            )
        }
        .onAppear {
            //loadFlashcards()
        }
    }
    
    //saves the high score
    func saveHighScore() {
        //guards against scores that are not higher than the high score
        if (currentScore <= highScore) { return }
        
        //gets all the high scores
        var allHighScores: [String: Int] = [:]
        
        if let data = UserDefaults.standard.data(forKey: "HighScores") {
            let decoder = JSONDecoder()
            
            if let decodedHighScores = try? decoder.decode([String: Int].self, from: data) {
                allHighScores = decodedHighScores
            }
        }
        
        //adds or updates a new high score
        allHighScores[flashcards[0].topic] = currentScore

        //save the latest data
        let encoder = JSONEncoder()
        
        if let encodedHighScores = try? encoder.encode(allHighScores) {
            UserDefaults.standard.set(encodedHighScores, forKey: "HighScores")
        }
    }

  /*  func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                topic.flashcards = decodedCards
            }
        }
    }*/
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
            flashcards: flashcards,
            highScore: highScore
        )
    }
}
