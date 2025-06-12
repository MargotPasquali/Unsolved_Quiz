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
        print("Récupération de \(limit) questions depuis Firestore")
        let snapshot = try await db.collection("questions").limit(to: limit).getDocuments()
        print("Nombre de documents récupérés: \(snapshot.documents.count)")
        let questions = snapshot.documents.compactMap { try? $0.data(as: Question.self) }
        print("Nombre de questions décodées: \(questions.count)")
        return questions
    }

    func isQuestionCorrect(question: Question, selectedAnswerID: UUID) -> Bool {
        guard let selectedAnswer = question.answers.first(where: { $0.id == selectedAnswerID }) else {
            print("Réponse sélectionnée non trouvée pour l'ID: \(selectedAnswerID)")
            return false
        }
        print("Réponse sélectionnée: \(selectedAnswer.text), est correcte: \(selectedAnswer.isCorrect)")
        return selectedAnswer.isCorrect
    }
}
