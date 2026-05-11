//
//  ChooseTopicView.swift
//  Assignment_3
//
//  Created by Elissa on 29/4/2026.
//

import SwiftUI

struct ChooseLevelView: View {
    @State var topic: Topic
    @State private var topics: [Topic] = []
    @State private var topicName = ""
    @State private var selectedTopic: String = "Choose Topic"
    @State private var selectedTopicObject: Topic = Topic(topicName: "")
    @StateObject var viewModel = TopicViewModel()
    
    var body: some View {
        VStack{
            
            VStack(spacing: 12) {
                
                Text("Choose a Difficulty Level")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppStyle.titleColor)
                    .padding(.top, 20)
                
                Text(topic.topicName)
                    .font(.headline)
                    .foregroundStyle(AppStyle.secondaryColor)
                
                NavigationLink(destination: GameView(flashcards: viewModel.flashcards.filter { $0.level == 1 }),
                               label: {
                    Text("Level 1")
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
                
                NavigationLink(destination: GameView(flashcards: viewModel.flashcards.filter { $0.level == 2 }),
                               label: {
                    Text("Level 2")
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
                
                NavigationLink(destination: GameView(flashcards: viewModel.flashcards.filter { $0.level == 3 }),
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
                
                NavigationLink(destination: GameView(flashcards: viewModel.flashcards),
                               label: {
                    Text("All Levels")
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
        }
        
        .onAppear() {
            viewModel.loadFlashcards(selectedTopic: topic)
        }
        .padding()
    }
    
    
    
}
#Preview {
    ChooseLevelView(topic: Topic(topicName: "New Topic"))
}
