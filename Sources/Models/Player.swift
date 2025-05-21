//
//  Player.swift
//  Unsolved
//
//  Created by Margot Pasquali on 14/05/2025.
//

import Foundation
import FirebaseFirestore

struct Player: Codable, Identifiable {
    @DocumentID var id: String?
    let question: TranslatedText
    let answers: [Answer]
    let imageUrl: String
    let anecdote: TranslatedText
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answers
        case imageUrl
        case anecdote
    }
}
