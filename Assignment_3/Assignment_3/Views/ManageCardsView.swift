//
//  ManageCardsView.swift
//  Assignment_3
//
//  Created by Elissa on 11/5/2026.
//



import SwiftUI

struct ManageCardsView: View {
    let topic: Topic
    @State private var flashcards: [Flashcard] = []
    @StateObject var viewModel = TopicViewModel()
    var body: some View {
        VStack{
            
            Text("Manage Flashcards")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(AppStyle.titleColor)
                .padding(.top, 20)
            
            Text(topic.topicName)
                .font(.headline)
                .foregroundStyle(AppStyle.secondaryColor)
            ScrollView{
                ForEach(viewModel.flashcards) { flashcard in
                    
                    HStack {
                        // display all flash cards in the topic
                        VStack(alignment: .leading) {
                            Text("Question: \(flashcard.question)")
                            Text("Answer: \(flashcard.answer)")
                                .foregroundColor(.gray)
                            Text("Level: \(flashcard.level)")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        // delete button for each flashcard
                        Button {
                            viewModel.deleteFlashcard(flashcard)
                        } label: {
                            
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(AppStyle.cardColor)
                    .cornerRadius(AppStyle.cornerRadius)
                    
                }
            }

                Spacer()
            
                
                NavigationLink(destination: AddCardsView(topic: topic),
                               label: {
                    Text("Add Cards")   //navigates to "Add Cards" screen
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                        )
                })
                  
        }
        .onAppear(){
            viewModel.loadFlashcards(selectedTopic: topic) // load all flashcards in the topic when the view appears
        }
        .padding()
        }
    


}

#Preview { // preview with test topic that contains one flashcard
    ManageCardsView(topic: Topic(topicName: "New Topic"))
}

