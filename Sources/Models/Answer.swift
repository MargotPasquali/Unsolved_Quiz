//
//  Answer.swift
//  Unsolved
//
//  Created by Margot Pasquali on 06/05/2025.
//

import Foundation

struct Answer: Codable, Identifiable {
    let id = UUID()
    let text: TranslatedText
    let isCorrect: Bool
    
    enum CodingKeys: String, CodingKey {
        case text
        case isCorrect
    }
}
