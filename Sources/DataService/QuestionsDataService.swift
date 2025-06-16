//
//  QuestionsDataService.swift
//  Unsolved
//
//  Created by Margot Pasquali on 13/05/2025.
//

import Foundation
import FirebaseFirestore

protocol QuestionsDataService {
    func fetchQuestionsForUser(limit: Int) async throws -> [Question]
    func isQuestionCorrect(question: Question, selectedAnswerID: UUID) -> Bool
}

final class RemoteQuestionsDataService: QuestionsDataService {
    
    func fetchQuestionsForUser(limit: Int) async throws -> [Question] {
            let db = Firestore.firestore()
            let languageKey = LanguageManager.shared.getLanguageKey()
            print("Récupération de \(limit) questions depuis Firestore en langue: \(languageKey)")
            let snapshot = try await db.collection("questions").limit(to: limit).getDocuments()
            print("Nombre de documents récupérés: \(snapshot.documents.count)")
            
            return snapshot.documents.map { doc in
                let data = doc.data()
                
                // Récupérer le texte de la question
                let questionText = data["question"] as? [String: String] ?? [:]
                let question = questionText[languageKey] ?? questionText["en"] ?? ""
                
                // Récupérer les réponses
                let answersData = data["answers"] as? [[String: Any]] ?? []
                let answers = answersData.map { answer in
                    let text = answer["text"] as? [String: String] ?? [:]
                    return Answer(
                        id: UUID(),
                        text: text,
                        isCorrect: answer["isCorrect"] as? Bool ?? false
                    )
                }
                
                // Récupérer l'anecdote
                let anecdoteText = data["anecdote"] as? [String: String] ?? [:]
                let anecdote = anecdoteText[languageKey] ?? anecdoteText["en"] ?? ""
                
                // Récupérer l'URL de l'image (non localisée)
                let imageUrl = data["imageUrl"] as? String ?? ""
                
                return Question(
                    id: doc.documentID,
                    question: [languageKey: question],
                    answers: answers,
                    imageUrl: imageUrl,
                    anecdote: [languageKey: anecdote]
                )
            }
        }

    func isQuestionCorrect(question: Question, selectedAnswerID: UUID) -> Bool {
        guard let selectedAnswer = question.answers.first(where: { $0.id == selectedAnswerID }) else {
            print("Réponse sélectionnée non trouvée pour l'ID: \(selectedAnswerID)")
            return false
        }
        print("Réponse sélectionnée: \(selectedAnswer.text[LanguageManager.shared.getLanguageKey()] ?? ""), est correcte: \(selectedAnswer.isCorrect)")
        return selectedAnswer.isCorrect
    }
}
