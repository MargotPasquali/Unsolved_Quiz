//
//  MainQuizView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI
import Kingfisher

struct MainQuizView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: MainQuizViewModel
    @State private var showingFeedback = false
    @State private var selectedAnswerID: UUID?
    @State private var isCorrect: Bool? = nil

    // MARK: - Constants
    private let languageKey = LanguageManager.shared.getLanguageKey()

    // MARK: - Init with loading questions
    init(viewModel: MainQuizViewModel) {
        self.viewModel = viewModel
        Task {
            await viewModel.loadQuestions()
        }
    }

    // MARK: - View
    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()

            if viewModel.isQuizFinished {
                ResultScoreView(username: viewModel.username, score: viewModel.score, endGameViewModel: EndGameViewModel())
            } else if viewModel.isLoading {
                Text("questions_loading_text")
                    .font(Font.custom("Dongle-Regular", size: 26))
                    .foregroundStyle(Color.navyBlue)
            } else if !viewModel.questions.isEmpty {
                let currentQuestion = viewModel.questions[viewModel.currentQuestionIndex]
                VStack {
                    HeaderView(username: viewModel.username, score: viewModel.score)

                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.violet, lineWidth: 4)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        Text("Question \(viewModel.currentQuestionIndex + 1)")
                            .font(Font.custom("Dongle-Regular", size: 40))
                            .foregroundStyle(Color.violet)
                            .padding(5)
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.violet, lineWidth: 4)
                            .padding(-1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        VStack {
                            if let url = URL(string: currentQuestion.imageUrl) {
                                KFImage(url)
                                    .placeholder { ProgressView() }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 160)
                                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 19, topTrailing: 19)))
                            } else {
                                Text("Aucune image")
                                    .frame(maxWidth: .infinity, maxHeight: 160)
                            }

                            Text(currentQuestion.question[languageKey] ?? "")
                                .font(Font.custom("Dongle-Regular", size: 26))
                                .foregroundStyle(Color.navyBlue)
                                .padding(.horizontal)

                            ForEach(currentQuestion.answers) { answer in
                                Button(action: {
                                    selectedAnswerID = answer.id
                                    isCorrect = viewModel.isQuestionCorrect(question: currentQuestion, selectedAnswerID: answer.id)

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        showingFeedback = true
                                    }
                                }) {
                                    Text(answer.text[languageKey] ?? "")
                                        .font(Font.custom("Dongle-Regular", size: 26))
                                        .foregroundStyle(Color.lightGray)
                                        .padding()
                                        .frame(maxWidth: .infinity, maxHeight: 50)
                                        .background(colorForAnswer(answer.id))
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                                .padding(.horizontal, 40)
                                .padding(.vertical, 3)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 20)

                if showingFeedback {
                    AnswerRevealView(
                        isCorrect: isCorrect ?? false,
                        anecdote: currentQuestion.anecdote[languageKey] ?? "",
                        onContinue: {
                            viewModel.answerQuestion(selectedAnswerID: selectedAnswerID ?? UUID())
                            showingFeedback = false
                            selectedAnswerID = nil
                            isCorrect = nil
                        }
                    )
                    .transition(.opacity)
                    .animation(.easeInOut, value: showingFeedback)
                }
            } else {
                Text("no_questions_available")
                    .font(Font.custom("Dongle-Regular", size: 26))
                    .foregroundStyle(Color.red)
            }
        }
    }

    private func colorForAnswer(_ answerID: UUID) -> Color {
        if let selectedID = selectedAnswerID, selectedID == answerID {
            if let isCorrect = isCorrect {
                return isCorrect ? .accent : .pinkRed
            }
        }
        return .navyBlue
    }
}

#Preview {
    MainQuizView(viewModel: MainQuizViewModel(username: "testUser"))
}
