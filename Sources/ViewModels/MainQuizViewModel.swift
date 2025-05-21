//
//  MainQuizViewModel.swift
//  Unsolved
//
//  Created by Margot Pasquali on 15/05/2025.
//

import Foundation

final class MainQuizViewModel: ObservableObject {
    
    enum MainQuizViewModelError: Error {
        case questionLoadingFailed
        case savingScoreFailed
        
        var localizedDescription: String {
            switch self {
            case .questionLoadingFailed:
                return "Questions loading failed"
            case .savingScoreFailed:
                return "Score saving failed"
            }
        }
    }
    
    //fetchNextQuestion
    private let questionService: QuestionsDataService
    private let totalQuestions = 10 // Nombre total de questions souhaité
    let username: String
    
    @Published var questions: [Question] = [] // Liste des questions
    @Published var currentQuestionIndex = 0 // Index de la question actuelle
    @Published var score = 0 // Score de l’utilisateur
    @Published var isQuizFinished = false // Indicateur de fin de quiz
    
    var errorMessage: String?

    init(username: String, questionsDataService: QuestionsDataService = RemoteQuestionsDataService()) {
        self.username = username
        self.questionService = questionsDataService
    }
    
    func loadQuestions() async {
        do {
            questions = try await questionService.fetchQuestionsForUser(limit: totalQuestions)
        } catch {
            errorMessage = MainQuizViewModelError.questionLoadingFailed.localizedDescription
        }
    }
    
    // Gérer la réponse à une question
    func answerQuestion(selectedAnswerID: UUID) {
        let currentQuestion = questions[currentQuestionIndex]
        if questionService.isQuestionCorrect(question: currentQuestion, selectedAnswerID: selectedAnswerID) {
            score += 1 // Incrémenter le score si la réponse est correcte
        }
        
        // Vérifier s’il reste des questions
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1 // Passer à la question suivante
        } else {
            isQuizFinished = true // Terminer le quiz si c’est la dernière question
        }
    }
    
    func isQuestionCorrect(question: Question, selectedAnswerID: UUID) -> Bool {
        return questionService.isQuestionCorrect(question: question, selectedAnswerID: selectedAnswerID)
    }
    
    func saveScore() async {
        do {
            try await RemotePlayerDataService().savePlayerScore(
                username: self.username,
                score: self.score
            )
        } catch {
            errorMessage = MainQuizViewModelError.savingScoreFailed.localizedDescription
        }
    }
}
