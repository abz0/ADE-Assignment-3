import SwiftUI

struct AddCardsView: View {
    @State private var topic = ""
    @State private var levelText = ""
    @State private var question = ""
    @State private var answer = ""
    
    @State private var flashcards: [Flashcard] = []
    
    @State private var showMessage = false
    @State private var messageText = ""
    @State private var messageColor: Color = .red
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Add Cards")
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                Text("Add Flashcard")
                    .font(.largeTitle)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Topic:")
                    TextField("Enter topic", text: $topic)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Level:")
                    TextField("Enter level", text: $levelText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    Text("Question:")
                    TextField("Enter question", text: $question)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Answer:")
                    TextField("Enter answer", text: $answer)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal, 20)
                
                if showMessage {
                    Text(messageText)
                        .font(.caption)
                        .foregroundStyle(messageColor)
                } else {
                    Text(" ")
                        .font(.caption)
                }
                
                Button("Add Flashcard") {
                    addFlashcard()
                }
                .font(.title3)
                .padding(.top, 10)
                
                Button("Cancel") {
                    clearFields()
                    dismiss()
                }
                .foregroundStyle(.gray)
                
                Text("Saved Cards: \(flashcards.count)")
                    .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Add Cards")
        .onAppear {
            loadFlashcards()
        }
    }
    
    func addFlashcard() {
        let cleanTopic = topic.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanTopic.isEmpty || cleanQuestion.isEmpty || cleanAnswer.isEmpty || levelText.isEmpty {
            messageText = "Please fill in all fields."
            messageColor = .red
            showMessage = true
            return
        }
        
        guard let level = Int(levelText), level >= 1 && level <= 5 else {
            messageText = "Level must be a number from 1 to 5."
            messageColor = .red
            showMessage = true
            return
        }
        
        let newFlashcard = Flashcard(
            topic: cleanTopic,
            level: level,
            question: cleanQuestion,
            answer: cleanAnswer
        )
        
        flashcards.append(newFlashcard)
        saveFlashcards()
        
        messageText = "Flashcard added successfully."
        messageColor = .green
        showMessage = true
        
        clearFields()
    }
    
    func clearFields() {
        topic = ""
        levelText = ""
        question = ""
        answer = ""
    }
    
    func saveFlashcards() {
        let encoder = JSONEncoder()
        
        if let encodedCards = try? encoder.encode(flashcards) {
            UserDefaults.standard.set(encodedCards, forKey: "Flashcards")
        }
    }
    
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards
            }
        }
    }
}

#Preview {
    AddCardsView()
}
