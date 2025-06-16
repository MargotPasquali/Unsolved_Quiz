//
//  Answer.swift
//  Unsolved
//
//  Created by Margot Pasquali on 06/05/2025.
//

import Foundation

struct Answer: Codable, Identifiable {
    let id: UUID
    let text: [String: String]
    let isCorrect: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case isCorrect
    }
}
