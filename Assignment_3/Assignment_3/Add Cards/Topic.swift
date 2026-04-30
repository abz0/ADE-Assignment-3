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
      /*
        if let data = UserDefaults.standard.data(forKey: "flashCards"),
           let decoded = try? JSONDecoder().decode([Flashcard].self, from: data) {
            
            self.flashcards = decoded.filter { $0.topic == "topicName" }
            
            
        }
        else{
            self.flashcards = []
        }*/
    }
}
