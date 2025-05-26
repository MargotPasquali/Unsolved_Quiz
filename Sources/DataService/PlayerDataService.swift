//
//  PlayerDataService.swift
//  Unsolved
//
//  Created by Margot Pasquali on 14/05/2025.
//

import Foundation
import FirebaseFirestore

protocol PlayerDataService {
    func saveUsername(_ username: String) async throws
    func savePlayerScore(username: String, score: Int) async throws
}

final class RemotePlayerDataService: PlayerDataService {
    private let db = Firestore.firestore()
    
    func saveUsername(_ username: String) async throws {
        print("Tentative d'enregistrement du nom d'utilisateur: \(username)")
        let data: [String: Any] = ["username": username, "timestamp": FieldValue.serverTimestamp(), "score": 0]
        try await db.collection("players").addDocument(data: data)
        print("Nom d'utilisateur enregistré avec succès: \(username)")
    }
    
    func savePlayerScore(username: String, score: Int) async throws {
        print("Tentative d'enregistrement du score pour \(username): \(score)")
        let data: [String: Any] = [
            "player": username,
            "score": score,
            "timestamp": FieldValue.serverTimestamp()
        ]
        try await db.collection("scores").addDocument(data: data)
        print("Score enregistré avec succès pour \(username): \(score)")
    }
}
