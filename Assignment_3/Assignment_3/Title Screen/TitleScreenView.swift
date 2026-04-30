//
//  TitleScreenView.swift
//  Assignment_3
//
//  Created by Abby on 23/4/2026.
//

import SwiftUI
struct TitleScreenView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Title Screen")
                    .font(.largeTitle)
                    .bold()

                VStack(spacing: 16) {
                
                    /*NavigationLink {
                        Text("Add Cards Screen")
                    } label: {
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
                    }*/
                    
                    //These links work
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
                            )
                    })
                    
                    Spacer()
                    
                    //Placeholder links
                    NavigationLink {
                        Text("Edit Cards Screen")
                    } label: {
                        Text("Edit Cards")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                    }

                    NavigationLink {
                        Text("High Score Screen")
                    } label: {
                        Text("High Score")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                    }

                    /*NavigationLink {
                        Text("Choose topic and difficulty to start the game")
                    } label: {
                        Text("Start Game")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow.opacity(0.5))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.yellow.opacity(0.7), lineWidth: 2)
                            )
                    }*/
                }

                Spacer()
            }
            .padding()
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
