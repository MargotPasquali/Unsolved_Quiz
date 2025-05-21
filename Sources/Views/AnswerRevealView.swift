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

    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()
                .opacity(0.3)
            
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color.violet, lineWidth: 4)
                .padding(-1)
                .frame(maxWidth: .infinity, maxHeight: 500)

            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color.violet)
                        .padding(-1)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                    Text(isCorrect ? String(localized: "answer.correct") : String(localized: "answer.incorrect"))
                        .font(Font.custom("Dongle-Bold", size: 40))
                        .foregroundStyle(isCorrect ? Color.accent : Color.pinkRed)
                }
                
                Text(FeedbackPhrase.random(for: isCorrect ? .good : .bad))
                    .font(Font.custom("Dongle-Bold", size: 26))
                    .foregroundStyle(Color.violet)
                    .padding(.leading, 10)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Anecdote : \(anecdote)")
                    .font(Font.custom("Dongle-Regular", size: 26))
                    .foregroundStyle(Color.navyBlue)
                    .padding(.leading, 10)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 40)

                Button(action: onContinue) {
                    HStack {
                        Spacer()
                        ZStack {
                            Image("Next")
                            Text(String(localized: "new_question_button"))
                                .font(Font.custom("Dongle-Bold", size: 28))
                                .foregroundStyle(Color.navyBlue)
                        }
                        Spacer()
                    }
                }
                
                
            }.offset(y: -270)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AnswerRevealView(
        isCorrect: true,
        anecdote: "Découvert à la dérive dans l’Atlantique, le Mary Celeste avait ses voiles partiellement déployées et ses provisions intactes, mais l’équipage avait disparu.",
        onContinue: {}
    )
}
