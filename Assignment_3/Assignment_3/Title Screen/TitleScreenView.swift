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

                NavigationLink("Add Cards") {
                    Text("Add Cards Screen")
                }

                NavigationLink("Edit Cards") {
                    Text("Edit Cards Screen")
                }

                NavigationLink("High Score") {
                    Text("High Score Screen")
                }

                NavigationLink("Start Game") {
                    Text("Choose topic and difficulty to start the game")
                }
            }
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
