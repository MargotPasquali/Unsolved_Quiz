//
//  MainQuizView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 08/05/2025.
//

import SwiftUI
import Kingfisher

struct MainQuizView: View {
    @ObservedObject var viewModel: MainQuizViewModel
    @State private var showingFeedback = false
    @State private var selectedAnswerID: UUID?
    @State private var isCorrect: Bool = false

    init(viewModel: MainQuizViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()

            if viewModel.isQuizFinished {
                ResultScoreView(username: viewModel.username)
            } else if !viewModel.questions.isEmpty {
                let currentQuestion = viewModel.questions[viewModel.currentQuestionIndex]
                VStack {
                    HeaderView(username: viewModel.username)

                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.violet, lineWidth: 4)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        Text("Question \(viewModel.currentQuestionIndex + 1)")
                            .font(Font.custom("Dongle-Regular", size: 40))
                            .foregroundStyle(Color.violet)
                            .padding()
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.violet, lineWidth: 4)
                            .padding(-1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        VStack {
                            if let url = URL(string: currentQuestion.imageUrl) {
                                KFImage(url)
                                    .placeholder {
                                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 19, topTrailing: 19))
                                            .frame(maxWidth: .infinity, maxHeight: 225)
                                            .foregroundColor(.violet)
                                    }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 160)
                                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 19, topTrailing: 19)))
                            } else {
                                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 19, topTrailing: 19))
                                    .frame(maxWidth: .infinity, maxHeight: 225)
                                    .foregroundColor(.violet)
                            }

                            Text(currentQuestion.question.fr)
                                .font(Font.custom("Dongle-Regular", size: 26))
                                .foregroundStyle(Color.navyBlue)
                                .lineLimit(nil)
                                .lineSpacing(0)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal)

                            ForEach(currentQuestion.answers) { answer in
                                Button(action: {
                                    selectedAnswerID = answer.id
                                    isCorrect = viewModel.isQuestionCorrect(
                                        question: currentQuestion,
                                        selectedAnswerID: answer.id
                                    )
                                    showingFeedback = true
                                }) {
                                        Text(answer.text.fr)
                                            .font(Font.custom("Dongle-Regular", size: 26))
                                            .foregroundStyle(Color.lightGray)
                                            .padding()
                                }.clipShape(RoundedRectangle(cornerRadius: 19))
                                    .foregroundStyle(Color.navyBlue)
                                    .frame(maxWidth: 300, maxHeight: 50)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 20)
                .sheet(isPresented: $showingFeedback) {
                    AnswerRevealView(
                        isCorrect: isCorrect,
                        anecdote: currentQuestion.anecdote.fr,
                        onContinue: {
                            viewModel.answerQuestion(selectedAnswerID: selectedAnswerID!)
                            showingFeedback = false
                        }
                    )
                }
            } else {
                Text("questions_loading_text")
                    .font(Font.custom("Dongle-Regular", size: 26))
                    .foregroundStyle(Color.navyBlue)
                    .onAppear {
                        Task {
                            await viewModel.loadQuestions()
                        }
                    }
            }
        }
    }
}

#Preview {
    MainQuizView(viewModel: MainQuizViewModel(username: "testUser"))
}
