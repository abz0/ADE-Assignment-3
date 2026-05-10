import Foundation

struct Topic: Identifiable, Hashable, Codable {
    let id = UUID()
    var topicName: String
    var highScore: Int
    var flashcards: [Flashcard]
    
    init(topicName: String, highScore: Int, flashcards: [Flashcard]) {
        
        self.topicName = topicName
        self.highScore = highScore
        self.flashcards = []
     
    }
}
