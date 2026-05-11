import SwiftUI

struct AddCardsView: View {
    let topic: Topic
    
    @State private var question = ""
    @State private var answer = ""
    @State private var level: Double = 1
    @State private var flashcards: [Flashcard] = []
    
    @State private var showMessage = false
    @State private var messageText = ""
    @State private var messageColor: Color = .red
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppStyle.sectionSpacing) {
                Text("Add Flashcard")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppStyle.titleColor)
                    .padding(.top, 20)
                
                Text(topic.topicName)
                    .font(.headline)
                    .foregroundStyle(AppStyle.secondaryColor)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Level:")
                        .font(.headline)
                    
                    HStack {
                        Text("\(Int(level))")
                        
                        Slider(value: $level, in: 1...3, step: 1)
                    }
                    
                    Text("Question:")
                        .font(.headline)
                    
                    TextField("Enter question", text: $question)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Answer:")
                        .font(.headline)
                    
                    TextField("Enter answer", text: $answer)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(AppStyle.pagePadding)
                .background(AppStyle.cardColor)
                .cornerRadius(AppStyle.cornerRadius)
                .padding(.horizontal, AppStyle.pagePadding)
                
                if showMessage {
                    Text(messageText)
                        .font(.caption)
                        .foregroundStyle(messageColor)
                } else {
                    Text(" ")
                        .font(.caption)
                }
                
                VStack(spacing: 12) {
                    Button(action: {
                        addFlashcard()
                    }) {
                        Text("Add Flashcard")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: AppStyle.buttonHeight)
                            .background(AppStyle.mainColor)
                            .cornerRadius(AppStyle.cornerRadius)
                    }
                    
                    Button(action: {
                        clearFields()
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundStyle(AppStyle.mainColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: AppStyle.buttonHeight)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppStyle.cornerRadius)
                                    .stroke(AppStyle.mainColor, lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, AppStyle.pagePadding)
                
                Text("Saved Cards: \(flashcards.count)")
                    .font(.footnote)
                    .foregroundStyle(AppStyle.secondaryColor)
                    .padding(.top, 8)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(AppStyle.backgroundColor)
        .onAppear {
            loadFlashcards()
        }
    }
    
    // save a new flashcard for the current topic
    func addFlashcard() {
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
        
        clearFields()
        loadFlashcards()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showMessage = false
        }
    }
    
    func clearFields() {
        level = 1
        question = ""
        answer = ""
    }
    
    // load flashcards only for the selected topic
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards.filter { flashcard in
                    flashcard.topic == topic.topicName
                }
            }
        } else {
            flashcards = []
        }
    }
}

#Preview {
    NavigationView {
        AddCardsView(topic: Topic(topicName: "New Topic 2", highScore: 100, flashcards: []))
    }
}
