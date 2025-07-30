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
            Color.darkBrown
                .ignoresSafeArea()

            Image("medium_pattern")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 900, maxHeight: 60)
                .offset(x: 0, y: 396)

            if viewModel.isQuizFinished {
                ResultScoreView(username: viewModel.username, score: viewModel.score, endGameViewModel: EndGameViewModel())
            } else if viewModel.isLoading {
                Text("questions_loading_text")
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 26))
                    .foregroundStyle(Color.blue)
            } else if !viewModel.questions.isEmpty {
                let currentQuestion = viewModel.questions[viewModel.currentQuestionIndex]
                VStack {
                    HeaderView(username: viewModel.username, score: viewModel.score)

                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundStyle(Color.lightBeige)
                            .padding(-1)
                            .frame(maxWidth: .infinity, maxHeight: 700)
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .foregroundStyle(Color.lightPink)
                                    .frame(width: 100, height: 25)

                                Text("Question \(viewModel.currentQuestionIndex + 1)")
                                    .font(Font.custom("BeVietnamPro-SemiBold", size: 14))
                                    .foregroundStyle(Color.darkPink)
                                    .padding(5)
                            }.offset(x: -117, y: 35)

                            Text(currentQuestion.question[languageKey] ?? "")
                                .font(Font.custom("BeVietnamPro-SemiBold", size: 19))
                                .foregroundStyle(Color.darkBrown)
                                .padding(.horizontal)
                                .padding(.top, 60)
                            
                            if let url = URL(string: currentQuestion.imageUrl) {
                                KFImage(url)
                                    .placeholder { ProgressView() }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 21))
                                    .padding(.vertical, 15)
                            } else {
                                Text("no_image_found")
                                    .frame(width: 300, height: 200)
                            }
                            ForEach(currentQuestion.answers) { answer in
                                Button(action: {
                                    selectedAnswerID = answer.id
                                    isCorrect = viewModel.checkAnswer(selectedAnswerID: answer.id)

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        showingFeedback = true
                                    }
                                }) {
                                    Text(answer.text[languageKey] ?? "")
                                        .font(Font.custom("BeVietnamPro-Bold", size: 17))
                                        .foregroundColor(colorForAnswerWithTextAndStroke(answer.id))
                                        .padding()
                                        .frame(maxWidth: .infinity, maxHeight: 43)
                                        .background(colorForAnswerWithBackground(answer.id))
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 19))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 19)
                                            .stroke(colorForAnswerWithTextAndStroke(answer.id), lineWidth: 3)
                                    )
                                .padding(.horizontal, 30)
                                .padding(.vertical, 5)
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
                            viewModel.answerQuestion()
                            showingFeedback = false
                            selectedAnswerID = nil
                            isCorrect = nil
                        },
                        viewModel: viewModel
                    )
                    .transition(.opacity)
                    .animation(.easeInOut, value: showingFeedback)
                }
            } else {
                Text("no_questions_available")
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 26))
                    .foregroundStyle(Color.red)
            }
        }
    }

    private func colorForAnswerWithBackground(_ answerID: UUID) -> Color {
        if let selectedID = selectedAnswerID, selectedID == answerID {
            if let isCorrect = isCorrect {
                return isCorrect ? .lightGreen : .lightOrange
            }
        }
        return .lightBeige
    }
    private func colorForAnswerWithTextAndStroke(_ answerID: UUID) -> Color {
        if let selectedID = selectedAnswerID, selectedID == answerID {
            if let isCorrect = isCorrect {
                return isCorrect ? .darkGreen : .darkOrange
            }
        }
        return .darkBrown
    }
}

#Preview {
    MainQuizView(viewModel: MainQuizViewModel(username: "testUser"))
}
