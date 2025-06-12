//
//  Player.swift
//  Unsolved
//
//  Created by Margot Pasquali on 14/05/2025.
//

import Foundation
import FirebaseFirestore

struct PlayerScore: Identifiable {
    let id: String
    let playerName: String
    let score: Int
}
