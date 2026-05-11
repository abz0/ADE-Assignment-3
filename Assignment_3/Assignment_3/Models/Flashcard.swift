import Foundation

// model for each flashcard
struct Flashcard: Identifiable, Codable, Hashable {
    let id = UUID()
    let topic: String
    let level: Int
    let question: String
    let answer: String
}
