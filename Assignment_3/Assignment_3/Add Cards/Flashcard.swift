import Foundation

struct Flashcard: Identifiable, Codable {
    var id = UUID()
    var topic: String
    var level: Int
    var question: String
    var answer: String
}
