//
//  ResultScoreView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//

import SwiftUI

struct ResultScoreView: View {
    let username: String

    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()

            AnimatedBackground()

            VStack(alignment: .center, spacing: 3) {
                Spacer()

                Text("congrats_text")
                    .foregroundStyle(Color.navyBlue)
                    .font(Font.custom("Dongle-Bold", size: 96))
                    .padding(.top, 30)
                Image("cup")
                    .resizable()
                    .frame(width: 90, height: 90)

                Text("game_is_over")
                    .foregroundStyle(Color.navyBlue)
                    .font(Font.custom("Dongle-Regular", size: 48))

                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.navyBlue, lineWidth: 4)
                        .frame(width: 350, height: 50)
                    Text("Votre score: 5/20")
                        .foregroundStyle(Color.navyBlue)
                        .font(Font.custom("Dongle-Bold", size: 48))
                }
                .padding(.bottom, 20)
                
                Spacer()
                NavigationLink(destination: RankingList()) {
                    Text("players_raking_button")
                        .frame(width: 350, height: 50)
                        .padding(5)
                        .background(Color.violet)
                        .font(Font.custom("Dongle-Bold", size: 40))
                        .foregroundStyle(Color.accent)
                        .cornerRadius(19)
                }
                .padding(.bottom, 10)

                NavigationLink(destination: WelcomeView(viewModel: StartNewGameViewModel())) {
                    Text("replay_button")
                        .frame(width: 350, height: 50)
                        .padding(5)
                        .background(Color.navyBlue)
                        .font(Font.custom("Dongle-Bold", size: 40))
                        .foregroundStyle(Color.lightGray)
                        .cornerRadius(19)
                }
            }
        }
    }
}

#Preview {
    ResultScoreView(username: "test")
}
