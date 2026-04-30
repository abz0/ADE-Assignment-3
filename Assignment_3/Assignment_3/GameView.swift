//
//  GameView.swift
//  Assignment_3
//
//  Created by Elissa Miraziz (School) on 28/4/2026.
//


import SwiftUI

struct GameView: View {
    @State var topic: Topic
    
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
                                                      

    
    ]
    //var topic: Topic
    var body: some View {
        VStack {
            Text("Test Flashcards: ").font(.title)
            MultiQuizView(flashcards: flashcardsTest)
            }
        .onAppear {
            loadFlashcards()
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
     )]))
}
