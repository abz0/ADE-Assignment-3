import Foundation

// model for topics
struct Topic: Identifiable, Hashable, Codable {
    let id = UUID()
    let topicName: String
    var highScore: Int = 0
    var flashcards: [Flashcard] = []
    
    init(topicName: String) { // each topic contains an array of flashcards
        
        self.topicName = topicName

     
    }
}
