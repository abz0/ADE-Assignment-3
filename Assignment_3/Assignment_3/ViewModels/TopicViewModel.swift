//
//  TopicViewModel.swift
//  Assignment_3
//
//  Created by Elissa Miraziz (School) on 11/5/2026.
//



import SwiftUI
import Combine


class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    @Published var flashcards: [Flashcard] = []
    //@Published private var flashcards: [Flashcard] = []
   // @Published private var flashcards: [Flashcard] = []
   // @Published private var flashcards: [Flashcard] = []
    
   
    
    func saveTopics() {
        let encoder = JSONEncoder()
        
        if let encodedCards = try? encoder.encode(topics) {
            UserDefaults.standard.set(encodedCards, forKey: "Topics")
        }
    }
    
    func loadTopics() {
        if let data = UserDefaults.standard.data(forKey: "Topics") {
            let decoder = JSONDecoder()
            
            if let decodedTopics = try? decoder.decode([Topic].self, from: data) {
                topics = decodedTopics
            }
        }
    }
    
    func loadTopicFlashcards(forKey key: String) -> [Flashcard] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let topic = try? JSONDecoder().decode(Topic.self, from: data) else {
            return []
        }
        
        return topic.flashcards
    }
    
    func loadFlashcards(selectedTopic: Topic?) {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards.filter { flashcard in
                    flashcard.topic == selectedTopic?.topicName
                }
            }
        } else {
            flashcards = []
        }
        
        /*if flashcards.count > 0 {
            showQuizLink = true
        } else {
            showQuizLink = false
        }*/
    }
    
}
