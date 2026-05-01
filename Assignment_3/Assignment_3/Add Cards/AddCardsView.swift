import SwiftUI

struct AddCardsView: View {
    let topic: Topic
    
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
                    
                    TextField("Enter level", text: $levelText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
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
                .padding(.horizontal, AppStyle.pagePadding)
                
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
                .padding(.horizontal, AppStyle.pagePadding)
                
                Text("Saved Cards: \(flashcards.count)")
                    .font(.footnote)
                    .foregroundStyle(AppStyle.secondaryColor)
                    .padding(.top, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(flashcards) { flashcard in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Level: \(flashcard.level)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Question: \(flashcard.question)")
                                .font(.subheadline)
                            
                            Text("Answer: \(flashcard.answer)")
                                .font(.subheadline)
                        }
                        .padding()
                        .background(AppStyle.cardColor)
                        .cornerRadius(AppStyle.cornerRadius)
                    }
                }
                .padding(.horizontal, AppStyle.pagePadding)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(AppStyle.backgroundColor)
        .navigationTitle("Add Cards")
        .onAppear {
            loadFlashcards()
        }
    }
    
    func addFlashcard() {
        let cleanQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanQuestion.isEmpty || cleanAnswer.isEmpty || levelText.isEmpty {
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
            topic: topic.topicName,
            level: level,
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
    }
    
    func clearFields() {
        levelText = ""
        question = ""
        answer = ""
    }
    
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
