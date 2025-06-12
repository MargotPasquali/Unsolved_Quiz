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
    func fetchPlayerScores() async throws -> [PlayerScore]
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

    func fetchPlayerScores() async throws -> [PlayerScore] {
        let snapshot = try await db.collection("scores")
            .order(by: "score", descending: true)
            .getDocuments()
        print("Nombre de documents récupérés : \(snapshot.documents.count)")
        snapshot.documents.forEach { doc in
            print("Données du document : \(doc.data())")
        }
        return snapshot.documents.map { doc in
            let data = doc.data()
            return PlayerScore(
                id: doc.documentID,
                playerName: data["player"] as? String ?? "Inconnu",
                score: data["score"] as? Int ?? 0
            )
        }
    }
}
