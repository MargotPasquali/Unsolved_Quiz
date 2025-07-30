//
//  AnswerRevealView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct AnswerRevealView: View {
    let isCorrect: Bool
    let anecdote: String
    let onContinue: () -> Void

    @ObservedObject var viewModel: MainQuizViewModel

    var body: some View {
        ZStack {
            Color.darkBrown
                .ignoresSafeArea()

            VStack {
                HeaderView(username: viewModel.username, score: viewModel.score)

                Spacer()

                        VStack(alignment: .leading, spacing: 10) {

                                HStack {
                                    Text(isCorrect ? String(localized: "answer.correct") : String(localized: "answer.incorrect"))
                                        .font(Font.custom("BeVietnamPro-Italic", size: 14))
                                        .foregroundStyle(Color.lightBeige)
                                        .padding(.leading, 10)
                                    Spacer()
                                }.padding(.top, 60)
                            Text(FeedbackPhrase.random(for: isCorrect ? .good : .bad))
                                .font(Font.custom("BeVietnamPro-Black", size: 24))
                                .foregroundStyle(Color.lightBeige)
                                .padding(.leading, 10)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)

                            Text(anecdote)
                                .font(Font.custom("BeVietnamPro-Italic", size: 14))
                                .foregroundStyle(Color.lightBeige)
                                .padding(.leading, 10)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)

                            Spacer()

                            Button(action: onContinue) {
                                HStack {
                                    Spacer()

                                        Text(String(localized: "new_question_button"))
                                            .font(Font.custom("BeVietnamPro-Bold", size: 17))
                                            .foregroundStyle(Color.lightBeige)
                                            .frame(width: 300, height: 40)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.lightBeige, lineWidth: 3)
                                            }
                                    
                                    Spacer()
                                }
                            }.padding(.bottom, 50)
                        }
                    }
                    .padding(.horizontal, 20)
                }

        }
    }
#Preview {
    AnswerRevealView(
        isCorrect: true,
        anecdote: "Découvert à la dérive dans l’Atlantique, le Mary Celeste avait ses voiles partiellement déployées et ses provisions intactes, mais l’équipage avait disparu.",
        onContinue: {}, viewModel: MainQuizViewModel(username: "testUser")
    )
}
