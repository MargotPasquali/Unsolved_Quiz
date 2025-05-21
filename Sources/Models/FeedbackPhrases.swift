//
//  FeedbackPhrases.swift
//  Unsolved
//
//  Created by Margot Pasquali on 11/05/2025.
//

import Foundation

enum FeedbackPhrase {
    case good
    case bad
    
    private static let goodKeys = [
        "feedback.good.1",
        "feedback.good.2",
        "feedback.good.3",
        "feedback.good.4"
    ]
    
    private static let badKeys = [
        "feedback.bad.1",
        "feedback.bad.2",
        "feedback.bad.3",
        "feedback.bad.4"
    ]
    
    static func random(for type: FeedbackPhrase) -> String {
        let keys: [String]
        switch type {
        case .good:
            keys = goodKeys
        case .bad:
            keys = badKeys
        }
        let randomKey = keys.randomElement() ?? "default"
        return String(localized: String.LocalizationValue(randomKey))
    }
}
