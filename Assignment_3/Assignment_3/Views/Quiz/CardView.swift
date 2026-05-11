//
//  CardView.swift
//  Assignment_3
//
//  Created by Abby on 29/4/2026.
//

import SwiftUI

//view of the card in the quiz
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
