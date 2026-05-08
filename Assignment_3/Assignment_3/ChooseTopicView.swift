//
//  ChooseTopicView.swift
//  Assignment_3
//
//  Created by Elissa Miraziz (School) on 29/4/2026.
//

import SwiftUI

struct ChooseTopicView: View {

            @State private var highScore: Int = 0
            @State private var topics: [Topic] = []
            @State private var topicName = ""
            @State private var selectedTopic: String = "Choose Topic"
            @State private var selectedTopicObject: Topic = Topic(topicName: "", highScore: 0, flashcards: []) //= Topic(topicName: "", highScore: 0, flashcards: [])
            //@State private var flashcards: [Flashcard] = []
            @State private var filteredCards: [Flashcard] = []
    
            var body: some View {
                VStack{
                    
                    VStack(spacing: 12) {
                        Spacer()
                        /*
                    Text("Add Topic")
                        .font(.largeTitle)
                    
                    
                        Text("Topic:")
                        TextField("Enter topic", text: $topicName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Topic") {
                            addTopic()
                            loadTopics()
                            
                        }
                        .font(.title3)
                        .padding(.top, 10)
                        
                        //Text("Choose Topic")
                        */
                        
                        /*

                        let topics2 = ["Topic 1", "Topic 2", "Topic 3"]

                        Menu {
                               ForEach(topics2, id: \.self) { topic in
                                   Button {
                                       selectedTopic = topic
                                   } label: {
                                       Text(topic)
                                   }
                               }
                           } label: {
                               Text(selectedTopic)
                           }
                        */
                        Menu {
                            ForEach(topics, id: \.self) { topic in
                                Button {
                                    selectedTopic = topic.topicName
                                    selectedTopicObject = topic
                                   /* if let selectedTopicObject {
                                        flashcards = selectedTopicObject.flashcards
                                    }*/
                                    
                                    //filteredCards = filterFlashcardsByLevel (cards: selectedTopicObject.flashcards, level: 1)
                                } label: {
                                    Text(topic.topicName)
                                }
                            }
                        } label: {
                            Text(selectedTopic)
                        }
                        .padding()
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                        .background(Color.gray)
                        
                        Spacer()
                        /*
                        Text("Difficulty Selection")
                        Button {
                        } label: {
                            Text("Easy: Levels 1-3")
                        }
                        .padding()
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                        .background(Color.gray)
                        
                        Button {
                        } label: {
                            Text("Medium: Levels 2-4")
                        }
                        .padding()
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                        .background(Color.gray)
                        
                        Button {
                        } label: {
                            Text("Hard: Levels 3-5")
                        }
                        .padding()
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                        .background(Color.gray)
                        
                        Spacer()
                        */
                        Text("High Score: \(highScore)")
                        
                        Spacer()
                        
                        if (topicName != ""){
                            var filteredCards = selectedTopicObject.flashcards.filter { $0.level == 1 }
                            
                            ForEach(selectedTopicObject.flashcards) { card in
                                Text("Question1: \(card.question)")
                                    .font(.headline)
                                
                                Text("Answer: \(card.answer)")
                                    .font(.headline)
                                
                                Text("Level: \(card.level)")
                                    .font(.headline)
                            }
                        }
                        else{
                            Text("Choose a topic")
                                .font(.headline)
                        }
                        
                        
                        NavigationLink(destination: GameView(topic: selectedTopicObject, flashcards: filteredCards),
                                           label: {
                                Text("Level 3")
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
                        
                        //Spacer()
                        /*
                        
                        ForEach(selectedTopicObject.flashcards) { flashcard in
                            
                            Text("Question: \(flashcard.question) Answer: \(flashcard.answer) Topic: \(flashcard.topic) Level: \(flashcard.level)")
                            Spacer()
                            }
                        */
                        //if (selectedTopicObject!==Topic(topicName: "", highScore: 0, flashcards: [])) {
                      /*  if let selectedTopicObject {
                            
                            
                            
                            AddCardsView(topic: selectedTopicObject)
                        }*/
                            //AddCardsView(topic: selectedTopicObject)
                        //}
                       /* NavigationLink(destination: GameView(/*topic: selectedTopicObject*/),
                            label: {
                                Text("Start Game")
                                
                        })
                        .padding()
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                        .background(Color.yellow)*/
                    }
                }
                .onAppear{
                    loadTopics()
                }
            }
                func addTopic() {
                    
                    var newTopic = Topic(
                        topicName: topicName,
                        highScore: 0,
                        flashcards: []
                        
                    )
                    
                    topics.append(newTopic)
                    saveTopics()
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
    
    func filterFlashcardsByLevel (cards: [Flashcard], level: Int) -> [Flashcard]{
        var filteredCards: [Flashcard] = []
        for card in cards {
            if card.level == level{
                filteredCards.append(card)
            }
        }
        return filteredCards
    }
         /*
            func loadFlashcards(topic: Topic) {
                if let data = UserDefaults.standard.data(forKey: "Flashcards") {
                    let decoder = JSONDecoder()
                    
                    if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                        flashcards = decodedCards
                    }
                }
            }*/
            }
/*

        #Preview {
            SettingsView()
        }
    }
}
*/
#Preview {
    ChooseTopicView()
}
