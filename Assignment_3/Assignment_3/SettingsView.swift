//
//  SettingsView.swift
//
//
//  Created by Elissa Miraziz (School) on 24/4/2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var highScore: Int = 0
    var body: some View {
        VStack{
            Text("Choose Topic")
            Menu {
                Button {
                } label: {
                    Text("Topic 1")
                }
                .padding()
                .clipShape(Capsule())
                .foregroundColor(.black)
                .background(Color.gray)
                
                Button {
                } label: {
                    Text("Topic 2")
                }
                Button {
                } label: {
                    Text("Topic 3")
                }
            } label: {
                Text("Choose Topic")
            }
            
            Spacer()
            
            Text("Difficulty Selection")
            Button {
            } label: {
                Text("Easy: Levels 1-3")
            }
            Button {
            } label: {
                Text("Medium: Levels 2-4")
            }
            Button {
            } label: {
                Text("Hard: Levels 3-5")
            }
            
            Spacer()
            
            Text("High Score: \(highScore)")
            
            Spacer()
            
            Button {
            } label: {
                Text("Start")
            }
        }
    }
}

#Preview {
    SettingsView()
}
