//
//  ChooseTopicView.swift
//  Assignment_3
//
//  Created by Elissa on 29/4/2026.
//

import SwiftUI

struct ChooseLevelView: View {
    @State var topic: Topic
    @State private var highScore: Int = 0
    @State private var topics: [Topic] = []
    @State private var topicName = ""
    @State private var selectedTopic: String = "Choose Topic"
    @State private var selectedTopicObject: Topic = Topic(topicName: "") 
    @State private var flashcards: [Flashcard] = []
    //@State private var filteredCards: [Flashcard] = []
    
    var body: some View {
        VStack{
            
            VStack(spacing: 12) {
                
                Text("Choose a Difficulty Level")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppStyle.titleColor)
                    .padding(.top, 20)
                
                Text(topic.topicName)
                    .font(.headline)
                    .foregroundStyle(AppStyle.secondaryColor)
                
                NavigationLink(destination: GameView(flashcards: flashcards.filter { $0.level == 1 }, highScore: highScore),
                               label: {
                    Text("Level 1")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow.opacity(0.5))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                        )
                })
                
                NavigationLink(destination: GameView(flashcards: flashcards.filter { $0.level == 2 }, highScore: highScore),
                               label: {
                    Text("Level 2")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow.opacity(0.5))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                        )
                })
                
                NavigationLink(destination: GameView(flashcards: flashcards.filter { $0.level == 3 }, highScore: highScore),
                               label: {
                    Text("Level 3")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow.opacity(0.5))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                        )
                })
                
                NavigationLink(destination: GameView(flashcards: flashcards),
                               label: {
                    Text("All Levels")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow.opacity(0.5))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                        )
                })
                
                
            }
        }
        
        .onAppear() {
            loadFlashcards()
            highScore = topic.highScore
        }
        .padding()
    }
    
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards.filter { flashcard in
                    flashcard.topic == topic.topicName
                }
            }
        } else {
            flashcards = []
        }
    }
    
}
#Preview {
    ChooseLevelView(topic: Topic(topicName: "New Topic"))
}
