//
//  WelcomeView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 07/05/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            AnimatedBackground()
            VStack(alignment: .center) {
                Text("Unsolved")
                    .font(.custom("JustMeAgainDownHere", size: 96))
                    .foregroundStyle(Color.violet)
                    .offset(y: -48)
                Text("Quiz")
                    .font(.custom("RubikGlitch-Regular", size: 64))
                    .foregroundStyle(Color.accent)
                    .offset(x: 78, y: -87)
                
                Button(action: {
                    // TO DO
                }) {
                    Text("new_game_button")
                        .frame(width: 240, height: 50)
                        .padding()
                        .background(Color.navyBlue)
                        .font(Font.custom("Dongle-Bold", size: 40))
                        .foregroundStyle(Color.white)
                        .cornerRadius(19)
                        .overlay(
                            RoundedRectangle(cornerRadius: 19)
                                .stroke(Color.accent, lineWidth: 1)
                        )
                        .padding(.top, 20)
                        .padding(.horizontal, 50)
                        .offset(y: -107)
                }
                
            }
        }
    }
}

#Preview {
    WelcomeView()
}
