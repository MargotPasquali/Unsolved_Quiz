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
    
    // FONCTIONS A CREER
    
    // FETCH QUESTIONS FOR USER (with fetch random logic). it needs to fetch randomly questions that left in the quiz
    
    // isQuestionCorrect: Bool (if the question is correct, we need to adapt the bad or good answer view)
    
    func fetchQuestionsForUser(limit: Int) async throws -> [Question] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("questions").limit(to: limit).getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: Question.self) }
    }
    
    
    func isQuestionCorrect(question: Question, selectedAnswerID: UUID) -> Bool {
        guard let selectedAnswer = question.answers.first(where: { $0.id == selectedAnswerID }) else {
            return false
        }
        return selectedAnswer.isCorrect
    }
}
