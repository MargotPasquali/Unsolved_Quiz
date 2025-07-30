//
//  ResultScoreView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct ResultScoreView: View {
    let username: String
    let score: Int
    
    @ObservedObject var endGameViewModel: EndGameViewModel

    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()

            AnimatedBackground()

            VStack(alignment: .center, spacing: 3) {
                Spacer()

                Text("congrats_text")
                    .foregroundStyle(Color.blue)
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 96))
                    .padding(.top, 30)
                Image("cup")
                    .resizable()
                    .frame(width: 90, height: 90)

                Text("game_is_over")
                    .foregroundStyle(Color.blue)
                    .font(Font.custom("BeVietnamPro-SemiBold", size: 48))

                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.blue, lineWidth: 4)
                        .frame(width: 350, height: 50)
                    Text("Votre score: \(score)/10")
                        .foregroundStyle(Color.blue)
                        .font(Font.custom("BeVietnamPro-SemiBold", size: 48))
                }
                .padding(.bottom, 20)

                Spacer()
                NavigationLink(destination: RankingList(viewModel: EndGameViewModel())) {
                    Text("players_raking_button")
                        .frame(width: 350, height: 50)
                        .padding(5)
                        .background(Color.red)
                        .font(Font.custom("BeVietnamPro-SemiBold", size: 40))
                        .foregroundStyle(Color.green)
                        .cornerRadius(19)
                }
                .padding(.bottom, 10)

                NavigationLink(destination: WelcomeView(viewModel: StartNewGameViewModel())) {
                    Text("replay_button")
                        .frame(width: 350, height: 50)
                        .padding(5)
                        .background(Color.blue)
                        .font(Font.custom("BeVietnamPro-SemiBold", size: 40))
                        .foregroundStyle(Color.gray)
                        .cornerRadius(19)
                }
            }
        }.onAppear {
            Task {
                print("Enregistrement du score : \(score) pour \(username)")
                await endGameViewModel.saveScore(username: username, score: score)
            }
        }
    }
}

#Preview {
    ResultScoreView(username: "test", score: 5, endGameViewModel: EndGameViewModel())
}
