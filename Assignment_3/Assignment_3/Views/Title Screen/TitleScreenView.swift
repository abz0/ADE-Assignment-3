//
//  TitleScreenView.swift
//  Assignment_3
//
//  Created by Abby on 23/4/2026.
//

import SwiftUI

//view of the title screen
struct TitleScreenView: View {
    @State private var highScore: Int = 0
    //@State private var topics: [Topic] = []
    @State private var topicName = ""
    @State private var selectedTopic: String = "Choose Topic"
    @State private var selectedTopicObject: Topic?
    //@State private var topics: [Topic] = []
    //@State private var flashcards: [Flashcard] = []
    
    @State private var showMessage = false
    @State private var messageText = ""
    @State private var messageColor: Color = .red
    
    @State private var showQuizLink = false
    @State private var streak: Int = 0
    
    @StateObject var viewModel = TopicViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("FlashStudy")
                    .font(.largeTitle)
                    .padding()
                    .bold()
                
                Text("Current Study Streak: \(streak) day(s)")
                    .font(.headline)
                    .foregroundStyle(.orange)
                    .padding(.bottom, 10)
                
                VStack(spacing: 12) {
                    HStack {
                        TextField("Enter topic", text: $topicName)
                            .textFieldStyle(.roundedBorder)
                        
                        
                        if  (topicName != ""){
                            Button("Add Topic") {
                                addTopic()
                                viewModel.loadTopics()
                                
                            }
                            .font(.title3)
                            .padding(.top, 10)
                        }
                        else{
                            Text("Add Topic")
                                .foregroundColor(.gray)
                        }
                        
                        
                    }
                    .padding()
                    
                    if showMessage {
                        Text(messageText)
                            .font(.caption)
                            .foregroundStyle(messageColor)
                            .padding()
                    } else {
                        Text(" ")
                            .font(.caption)
                            .padding()
                    }
                    
                    if !viewModel.topics.isEmpty {
                        Menu {
                            ForEach(viewModel.topics, id: \.self) { topic in
                                Button {
                                    selectedTopic = topic.topicName
                                    selectedTopicObject = topic
                                    
                                    if let selectedTopicObject {
                                        viewModel.loadFlashcards(selectedTopic: selectedTopicObject)
                                        viewModel.flashcards = selectedTopicObject.flashcards
                                    }
                                } label: {
                                    Text(topic.topicName)
                                }
                            }
                        } label: {
                            Text(selectedTopic)
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(AppStyle.cardColor)
                        .cornerRadius(AppStyle.cornerRadius)
                        
                        Spacer()
                    }
                    
                    VStack {
                        VStack(spacing: 16) {
                            if let selectedTopicObject {
                                //Text("High Score: \(selectedTopicObject.highScore)")
                                
                                NavigationLink(destination: ManageCardsView(topic: selectedTopicObject),
                                               label: {
                                    Text("Manage Cards")
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
                                
                                if showQuizLink {
                                    NavigationLink(destination: ChooseLevelView(topic: selectedTopicObject),
                                                   label: {
                                        Text("Quiz")
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.yellow.opacity(0.5))
                                            .cornerRadius(12)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                                            )
                                    })
                                } else {
                                    Text("Add cards to start the quiz.")
                                }
                            }
                            Spacer()
                        }
                        .onAppear {
                            viewModel.loadFlashcards(selectedTopic: selectedTopicObject)
                            if viewModel.flashcards.count > 0 {
                                showQuizLink = true
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.loadTopics()
                streak = StreakManager.shared.getCurrentStreak()
            }
        }
    }
    func addTopic() {
        let newTopic = Topic(
            topicName: topicName,
            highScore: 0,
            flashcards: []
        )
        
        viewModel.topics.append(newTopic)
        viewModel.saveTopics()
        
        messageText = "Topic added successfully."
        messageColor = .green
        showMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showMessage = false
        }
    }
    
    
    
}

#Preview {
    TitleScreenPreviewWrapper()
}

struct TitleScreenPreviewWrapper: View {
    var body: some View {
        TitleScreenView()
    }
}
