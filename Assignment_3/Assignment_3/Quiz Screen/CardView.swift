//
//  CardView.swift
//  Assignment_3
//
//  Created by Abby on 29/4/2026.
//

import SwiftUI

//displays the quiz screen
struct CardView: View {
    var text: String //text that the card will display
    var colorMain: Color //color of the card
    var colorBorder: Color //color of the card border

    var onTap: () -> Void //when the card is tapped
    
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(colorMain)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(colorBorder, lineWidth: 2)
            )
            .onTapGesture {
                onTap()
            }
    }
}

#Preview {
    CardPreviewWrapper()
}

struct CardPreviewWrapper: View {
    let text: String = "Sample Text"
    var colorMain: Color  {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    var colorBorder: Color  {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }

    var body: some View {
        CardView(
            text: text,
            colorMain: colorMain,
            colorBorder: colorBorder
        ) {
            print("Card is tapped")
        }
    }
}
