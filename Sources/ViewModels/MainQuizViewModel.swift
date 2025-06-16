//
//  MainQuizViewModel.swift
//  Unsolved
//
//  Created by Margot Pasquali on 15/05/2025.
//

import Foundation

@MainActor
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

    private let questionService: QuestionsDataService
    private let totalQuestions = 10
    let username: String

    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var isQuizFinished = false
    @Published var isLoading = true

    var errorMessage: String?

    init(username: String, questionsDataService: QuestionsDataService = RemoteQuestionsDataService()) {
        self.username = username
        self.questionService = questionsDataService
    }

    func loadQuestions() async {
        do {
            let fetchedQuestions = try await questionService.fetchQuestionsForUser(limit: totalQuestions)
            print("Questions récupérées : \(fetchedQuestions.count)")
            await MainActor.run {
                print("Avant assignation : questions.count = \(questions.count)")
                questions = fetchedQuestions
                isLoading = false
                print("Après assignation : questions.count = \(questions.count)")
            }
        } catch {
            await MainActor.run {
                errorMessage = "Erreur lors du chargement des questions : \(error.localizedDescription)"
                isLoading = false
                print("Erreur : \(error.localizedDescription)")
            }
        }
    }

    func answerQuestion(selectedAnswerID: UUID) {
        print("Réponse sélectionnée pour la question \(currentQuestionIndex + 1): \(selectedAnswerID)")
        let currentQuestion = questions[currentQuestionIndex]
        if questionService.isQuestionCorrect(question: currentQuestion, selectedAnswerID: selectedAnswerID) {
            score += 1
            print("Réponse correcte, score actuel: \(score)")
        } else {
            print("Réponse incorrecte")
        }

        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            print("Passage à la question suivante: \(currentQuestionIndex + 1)")
        } else {
            isQuizFinished = true
            print("Quiz terminé, score final: \(score)")
        }
    }

    func isQuestionCorrect(question: Question, selectedAnswerID: UUID) -> Bool {
        return questionService.isQuestionCorrect(question: question, selectedAnswerID: selectedAnswerID)
    }

    func saveScore() async {
        print("Tentative d'enregistrement du score pour \(username): \(score)")
        do {
            try await RemotePlayerDataService().savePlayerScore(username: self.username, score: self.score)
            print("Score enregistré avec succès")
        } catch {
            print("Erreur lors de l'enregistrement du score: \(error.localizedDescription)")
            errorMessage = MainQuizViewModelError.savingScoreFailed.localizedDescription
        }
    }
}
