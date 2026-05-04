
//
//  EndScreen.swift
//  Assignment_3
//
//  Created by Abby on 4/5/2026.
//

import SwiftUI

//displays the quiz screen
struct EndScreenView: View {
    var score: Int
    
    var body: some View {
        VStack {
            Text("You have completed the quiz!")
            
            Text("Score: \(score)")

            NavigationLink(destination: TitleScreenView(),
                           label: {
                Text("Go back to Title Screen")
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
}

#Preview {
    EndScreenPreviewWrapper()
}

struct EndScreenPreviewWrapper: View {
    let score: Int = Int.random(in: 1...999)

    var body: some View {
        EndScreenView(score: score)
    }
}
