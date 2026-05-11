//
//  TopicViewModel.swift
//  Assignment_3
//
//  Created by Elissa on 11/5/2026.
//



import SwiftUI
import Combine


class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    @Published var flashcards: [Flashcard] = []
    @Published var showQuizLink: Bool = false
    @Published var showMessage: Bool = false
    @Published var messageText: String = ""
    @Published var messageColor: Color = .red
    @Published var success: Bool = false
    
    //@Published private var flashcards: [Flashcard] = []
   // @Published private var flashcards: [Flashcard] = []
   // @Published private var flashcards: [Flashcard] = []
    
    // add a new topic
    func addTopic(topicName: String) {
        let newTopic = Topic(
            topicName: topicName,
        )
        
        topics.append(newTopic)
        saveTopics()
        
        messageText = "Topic added successfully."
        messageColor = .green
        showMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMessage = false
        }
    }
    
    // save all topics to UserDefaults
    func saveTopics() {
        let encoder = JSONEncoder()
        
        if let encodedCards = try? encoder.encode(topics) {
            UserDefaults.standard.set(encodedCards, forKey: "Topics")
        }
    }
    
    // load all topics from UserDefaults
    func loadTopics() {
        if let data = UserDefaults.standard.data(forKey: "Topics") {
            let decoder = JSONDecoder()
            
            if let decodedTopics = try? decoder.decode([Topic].self, from: data) {
                topics = decodedTopics
            }
        }
    }
    
   
    // load all flashcards for the selected topic
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
         // hide quiz link if there are no flashcards in the array
        if flashcards.count > 0 {
            showQuizLink = true
        } else {
            showQuizLink = false
        }
        
      
    }
    
    

    
    
    
    // add a new flashcard for the current topic
    // UserDefaults is used here to store flashcards locally on the device
    func addFlashcard(topic: Topic, level: Double, question: String, answer: String) {
        let cleanQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanQuestion.isEmpty || cleanAnswer.isEmpty {
            messageText = "Please fill in all fields."
            messageColor = .red
            showMessage = true
            return
        }
        
        let newFlashcard = Flashcard(
            topic: topic.topicName,
            level: Int(level),
            question: cleanQuestion,
            answer: cleanAnswer
        )
        
        var allFlashcards: [Flashcard] = []
        
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                allFlashcards = decodedCards
            }
        }
        
        allFlashcards.append(newFlashcard)
        
        let encoder = JSONEncoder()
        
        if let encodedCards = try? encoder.encode(allFlashcards) {
            UserDefaults.standard.set(encodedCards, forKey: "Flashcards")
        }
        
        messageText = "Flashcard added successfully."
        messageColor = .green
        showMessage = true
        
        success=true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMessage = false
        }
    }
    
    // delete a single flashcard
    func deleteFlashcard(_ card: Flashcard) {
        flashcards.removeAll { $0.id == card.id }
        
            let encoder = JSONEncoder()
            
            if let encodedCards = try? encoder.encode(flashcards) {
                UserDefaults.standard.set(encodedCards, forKey: "Flashcards")
            }
        }
}

