//
//  Question.swift
//  Unsolved
//
//  Created by Margot Pasquali on 06/05/2025.
//

import Foundation
import FirebaseFirestore

struct Question: Codable, Identifiable {
    @DocumentID var id: String?
    let question: [String: String]
    let answers: [Answer]
    let imageUrl: String
    let anecdote: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answers
        case imageUrl
        case anecdote
    }
}
