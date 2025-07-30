//
//  WelcomeView.swift
//  Unsolved
//
//  Created by Margot Pasquali on 07/05/2025.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: StartNewGameViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedBackground()

                VStack(alignment: .center) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .offset(y: -30)

                    Spacer()

                    NavigationLink(destination: StartNewGameView(viewModel: viewModel)) {
                        Text("new_game_button")
                            .navigationBarBackButtonHidden(true)
                            .frame(width: 220, height: 40)
                            .padding()
                            .font(Font.custom("BeVietnamPro-SemiBold", size: 22))
                            .foregroundStyle(Color.lightBeige)
                            .overlay(
                                RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.lightBeige, lineWidth: 1)
                            )
                    }.offset(y: -50)

                    Spacer()

                    VStack {
                        Text("HELLO DUDE,")
                            .font(Font.custom("BeVietnamPro-SemiBold", size: 14))
                            .foregroundStyle(Color.lightBeige)

                        Text("YOUR NOT READY TO THE NEXT LEVEL\nPLEASE BE CAREFUL")
                            .font(Font.custom("BeVietnamPro-Light", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.lightBeige)
                            .padding(.bottom, 15)

                        Capsule()
                            .frame(width: 34, height: 1)
                            .foregroundColor(.lightBeige)

                    }.offset(y: -70)
                }
            }

            }
        }
    }

#Preview {
    WelcomeView(viewModel: StartNewGameViewModel())
}
