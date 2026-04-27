//
//  QuizCardEnum.swift
//  Assignment_3
//
//  Created by Abby on 27/4/2026.
//

import SwiftUI

//enum for the quiz cards
enum QuizCard {
    case questionDefault
    case questionBorder
    case answerDefault
    case answerBorder
    case selectedDefault
    case selectedBorder

    var color: Color {
        switch self {

        case .questionDefault:
            return Color.gray.opacity(0.3)

        case .questionBorder:
            return Color.gray.opacity(0.5)

        case .answerDefault:
            return Color.teal.opacity(0.3)

        case .answerBorder:
            return Color.teal.opacity(0.5)

        case .selectedDefault:
            return Color.yellow.opacity(0.5)

        case .selectedBorder:
            return Color.yellow.opacity(0.7)
        }
    }
}

