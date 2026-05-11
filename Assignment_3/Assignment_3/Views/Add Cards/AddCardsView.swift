import SwiftUI

// view for adding flashcards to the selected topic
struct AddCardsView: View {
    let topic: Topic
    
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var level: Double = 1
    
    @StateObject var viewModel = TopicViewModel()
    
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
                
                if viewModel.showMessage {
                    Text(viewModel.messageText)
                        .font(.caption)
                        .foregroundStyle(viewModel.messageColor)
                } else {
                    Text(" ")
                        .font(.caption)
                }
                
                VStack(spacing: 12) {
                    Button(action: {
                        viewModel.addFlashcard(topic: topic, level: level, question: question, answer: answer)
                        if viewModel.success==true{ // if the flashcard was added successfully, clear the input fields and reload the flashcards
                            clearFields()
                            viewModel.loadFlashcards(selectedTopic: topic)
                            viewModel.success=false
                        }
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
                
                Text("Saved Cards: \(viewModel.flashcards.count)")
                    .font(.footnote)
                    .foregroundStyle(AppStyle.secondaryColor)
                    .padding(.top, 8)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .background(AppStyle.backgroundColor)
        .onAppear {
            viewModel.loadFlashcards(selectedTopic: topic)
        }
    }
    
    
    
    // reset the input fields
    func clearFields() {
        level = 1
        question = ""
        answer = ""
    }
    
    
    
    
}

#Preview {
    NavigationView {
        AddCardsView(topic: Topic(topicName: "New Topic 2"))
    }
}
