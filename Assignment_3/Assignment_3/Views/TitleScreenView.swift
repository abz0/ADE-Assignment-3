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
    @State private var topics: [Topic] = []
    @State private var topicName = ""
    @State private var selectedTopic: String = "Choose Topic"
    @State private var selectedTopicObject: Topic?
    @State private var flashcards: [Flashcard] = []
    
    @State private var showMessage = false
    @State private var messageText = ""
    @State private var messageColor: Color = .red
    
    @State private var showQuizLink = false
    @State private var streak: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("App Title")
                    .font(.largeTitle)
                    .padding()
                
                Text("Current Study Streak: \(streak) day(s)")
                    .font(.headline)
                    .foregroundStyle(.orange)
                    .padding(.bottom, 10)
                
                VStack(spacing: 12) {
                    HStack {
                        TextField("Enter topic", text: $topicName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Topic") {
                            addTopic()
                            loadTopics()
                        }
                        .font(.title3)
                        .padding(.top, 10)
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
                    
                    if !topics.isEmpty {
                        Menu {
                            ForEach(topics, id: \.self) { topic in
                                Button {
                                    selectedTopic = topic.topicName
                                    selectedTopicObject = topic
                                    
                                    if let selectedTopicObject {
                                        loadFlashcards()
                                        flashcards = selectedTopicObject.flashcards
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
                                
                                NavigationLink(destination: SettingsView(topic: selectedTopicObject),
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
                            loadFlashcards()
                            if flashcards.count > 0 {
                                showQuizLink = true
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .onAppear {
                loadTopics()
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
        
        topics.append(newTopic)
        saveTopics()
        
        messageText = "Topic added successfully."
        messageColor = .green
        showMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showMessage = false
        }
    }
    
    func saveTopics() {
        let encoder = JSONEncoder()
        
        if let encodedCards = try? encoder.encode(topics) {
            UserDefaults.standard.set(encodedCards, forKey: "Topics")
        }
    }
    
    func loadTopics() {
        if let data = UserDefaults.standard.data(forKey: "Topics") {
            let decoder = JSONDecoder()
            
            if let decodedTopics = try? decoder.decode([Topic].self, from: data) {
                topics = decodedTopics
            }
        }
    }
    
    func loadTopicFlashcards(forKey key: String) -> [Flashcard] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let topic = try? JSONDecoder().decode(Topic.self, from: data) else {
            return []
        }
        
        return topic.flashcards
    }
    
    func loadFlashcards() {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards.filter { flashcard in
                    flashcard.topic == selectedTopicObject?.topicName
                }
            }
        } else {
            flashcards = []
        }
        
        if flashcards.count > 0 {
            showQuizLink = true
        } else {
            showQuizLink = false
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
