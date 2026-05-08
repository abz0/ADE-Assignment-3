//
//  SettingsView.swift
//
//
//  Created by Elissa Miraziz (School) on 24/4/2026.
//

// THE TOPIC IN THE ADD CARD VIEW DOES NOT CHANGE WHEN THE TOPIC IN THE MENU IS CHANGED
import SwiftUI

struct SettingsView: View {
    let topic: Topic
    @State private var highScore: Int = 0
    @State private var topics: [Topic] = []
    @State private var topicName = ""
    @State private var selectedTopic: String = "Choose Topic"
    @State private var selectedTopicObject: Topic? //= Topic(topicName: "", highScore: 0, flashcards: [])
    @State private var flashcards: [Flashcard] = []
    var body: some View {
        VStack{
            
            Text("Manage Flashcards")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(AppStyle.titleColor)
                .padding(.top, 20)
            
            Text(topic.topicName)
                .font(.headline)
                .foregroundStyle(AppStyle.secondaryColor)
            ScrollView{
                ForEach(flashcards) { flashcard in
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text("Question: \(flashcard.question)")
                            Text("Answer: \(flashcard.answer)")
                                .foregroundColor(.gray)
                            Text("Level: \(flashcard.level)")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            delete(flashcard)
                        } label: {
                            
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(AppStyle.cardColor)
                    .cornerRadius(AppStyle.cornerRadius)
                    
                }
            }
            /*
            
            ForEach(topic.flashcards) { flashcard in
                
                Text("Question: \(flashcard.question) Answer: \(flashcard.answer) Topic: \(flashcard.topic) Level: \(flashcard.level)")
                Spacer()
                }
            */
                Spacer()
                NavigationLink(destination: AddCardsView(topic: topic),
                               label: {
                    Text("Add Cards")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                        )
                })
                  
        }
        .onAppear(){
            loadFlashcards()
        }
        .padding()
        }
    
     
    func loadTopicFlashcards(forKey key: String) -> [Flashcard] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let topic = try? JSONDecoder().decode(Topic.self, from: data) else {
            return []
        }

        return topic.flashcards
    }
    
    func delete(_ card: Flashcard) {
        flashcards.removeAll { $0.id == card.id }
        
        
            let encoder = JSONEncoder()
            
            if let encodedCards = try? encoder.encode(flashcards) {
                UserDefaults.standard.set(encodedCards, forKey: "Flashcards")
            }
        }
        
    
    /*func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards
            }
        }
    }*/
    
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
    //}
}

#Preview {
    SettingsView(topic: Topic(topicName: "New Topic", highScore: 100, flashcards: [Flashcard(
        topic: "TestTopic",
        level: 1,
        question: "TestQuestion1",
        answer: "TestAnswer1"
    )]))
}

