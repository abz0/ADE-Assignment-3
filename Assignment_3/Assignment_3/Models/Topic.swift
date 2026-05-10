import Foundation

// model for topics
struct Topic: Identifiable, Hashable, Codable {
    let id = UUID()
    var topicName: String
    var highScore: Int
    var flashcards: [Flashcard]
    
    init(topicName: String, highScore: Int, flashcards: [Flashcard]) { // each topic contains an array of flashcards
        
        self.topicName = topicName
        self.highScore = highScore
        self.flashcards = []
     
    }
}
