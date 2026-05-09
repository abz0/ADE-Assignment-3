//
//  TitleScreenView.swift
//  Assignment_3
//
//  Created by Abby on 23/4/2026.
//



//
//  SettingsView.swift
//
//
//  Created by Elissa Miraziz (School) on 24/4/2026.
//


import SwiftUI

struct TitleScreenView: View {
    @State private var highScore: Int = 0
    @State private var topics: [Topic] = []
    @State private var topicName = ""
    @State private var selectedTopic: String = "Choose Topic"
    @State private var selectedTopicObject: Topic? //= Topic(topicName: "", highScore: 0, flashcards: [])
    @State private var flashcards: [Flashcard] = []
    
    
    @State private var showMessage = false
    @State private var messageText = ""
    @State private var messageColor: Color = .red
    
    @State private var showQuizLink = false
    
    var body: some View {
        NavigationStack {
        VStack{
            
            Text("App Title")
                .font(.largeTitle)
                .padding()
            
            VStack(spacing: 12) {
                //Text("Add or Choose a Topic:")
                HStack{
                    TextField("Enter topic", text: $topicName)
                        .textFieldStyle(.roundedBorder)
                        
                    
                    if  (topicName != ""){
                        Button("Add Topic") {
                            addTopic()
                            loadTopics()
                            
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
                //Text("Choose Topic")
                
                
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
                if !topics.isEmpty { //clear user defaults and test this
                    Menu {
                        ForEach(topics, id: \.self) { topic in
                            Button {
                                //showQuizLink = false
                                selectedTopic = topic.topicName
                                selectedTopicObject = topic
                                if let selectedTopicObject {
                                 loadFlashcards()
                                 flashcards = selectedTopicObject.flashcards
                                    /*if flashcards.count > 0 {
                                        showQuizLink = true
                                    }*/
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
                    /*.padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(8)*/
                    //.padding()
                    //.clipShape(Capsule())
                    //.foregroundColor(.black)
                    //.background(Color.gray)
                    
                    Spacer()
                }
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
                
                
                    
                        VStack {
                            /*Text("Title Screen")
                                .font(.largeTitle)
                                .bold()*/
                            
                            VStack(spacing: 16) {
                                if let selectedTopicObject {
                                    Text("High Score: \(selectedTopicObject.highScore)")
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
                                        NavigationLink(destination: ChooseTopicView(topic: selectedTopicObject),
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
                                    }
                                    else {
                                        Text("Add cards to start the quiz.")
                                    }
                                }
                                Spacer()
                            }
                            .onAppear(){
                                loadFlashcards()
                                if flashcards.count>0{
                                    showQuizLink = true
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        
                    }
                
                
                //Spacer()
                /*
                
                ForEach(selectedTopicObject.flashcards) { flashcard in
                    
                    Text("Question: \(flashcard.question) Answer: \(flashcard.answer) Topic: \(flashcard.topic) Level: \(flashcard.level)")
                    Spacer()
                    }
                */
                //if (selectedTopicObject!==Topic(topicName: "", highScore: 0, flashcards: [])) {
               /* if let selectedTopicObject {
                    
                    
                    
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
            //showQuizLink = false
        }
        
        if flashcards.count > 0 {
            showQuizLink = true
        }
        else{
            showQuizLink = false
        }
    }
    /*func loadFlashcards(topic: Topic) {
        if let data = UserDefaults.standard.data(forKey: "Flashcards") {
            let decoder = JSONDecoder()
            
            if let decodedCards = try? decoder.decode([Flashcard].self, from: data) {
                flashcards = decodedCards
            }
        }
    }*/
    }


#Preview {
    TitleScreenPreviewWrapper()
}

struct TitleScreenPreviewWrapper: View {
    var body: some View {
        TitleScreenView()
    }
}



/*
import SwiftUI
struct TitleScreenView: View {
    var body: some View {
        
        //------
        NavigationStack {
            VStack {
                Text("Title Screen")
                    .font(.largeTitle)
                    .bold()

                VStack(spacing: 16) {
                
                    NavigationLink(destination: SettingsView(),
                        label: {
                            Text("Add Cards")
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
                    NavigationLink(destination: ChooseTopicView(),
                        label: {
                            Text("Start")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow.opacity(0.5))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                            )                    })
                    Spacer()         }
                Spacer()
            }
            .padding()
        }
        
        //-----
        
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
*/
