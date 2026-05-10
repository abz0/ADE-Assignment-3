import Foundation

// model for each flashcard
struct Flashcard: Identifiable, Codable, Hashable {
    let id = UUID()
    var topic: String
    var level: Int
    var question: String
    var answer: String
}
