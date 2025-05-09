//
//  AnswerRevealView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct AnswerRevealView: View {
    var isCorrect: Bool = false
    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()
                .opacity(0.3)
            
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color.violet, lineWidth: 4)
                .padding(-1)
                .frame(maxWidth: .infinity, maxHeight: 500)

            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color.violet)
                        .padding(-1)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                    
                    if isCorrect {
                        Text("Bonne réponse")
                            .font(Font.custom("Dongle-Bold", size: 40))
                            .foregroundStyle(Color.accent)
                    } else {
                        Text("Mauvaise réponse")
                            .font(Font.custom("Dongle-Bold", size: 40))
                            .foregroundStyle(Color.pinkRed)
                    }
                }
                Text("Bravo, c'est exact!")
                    .font(Font.custom("Dongle-Bold", size: 26))
                    .foregroundStyle(Color.violet)
                    .padding(.leading, 10)
                
                Text("Anecdote : Découvert à la dérive dans l’Atlantique, le Mary Celeste avait ses voiles partiellement déployées et ses provisions intactes, mais l’équipage avait disparu. Les hypothèses incluent des pirates ou des extraterrestres, sans preuve définitive.")
                    .font(Font.custom("Dongle-Regular", size: 26))
                    .foregroundStyle(Color.navyBlue)
                    .padding(.leading, 10)

                Button(action: {
                    // TO DO
                }) {
                    HStack {
                        Spacer()
                        ZStack {
                            Image("Next")
                            Text("new_question_button")
                                .font(Font.custom("Dongle-Bold", size: 28))
                                .foregroundStyle(Color.navyBlue)
                        }
                        Spacer()
                    }
                }.padding(.bottom, 73)
                

            }
            
        }.padding(.horizontal, 20)
        
    }
}



#Preview {
    AnswerRevealView()
}
