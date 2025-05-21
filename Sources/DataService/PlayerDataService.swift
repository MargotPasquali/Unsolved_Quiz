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
        let data : [String: Any] = ["username": username, "timestamp": FieldValue.serverTimestamp()]
        try await db.collection("players").addDocument(data: data)
    }
    
    func savePlayerScore(username: String, score: Int) async throws {
        let data : [String: Any] = [
            "player": username,
            "score": score,
            "timestamp": FieldValue.serverTimestamp()
        ]
        
        try await db.collection("scores").addDocument(data: data)
    }
}
