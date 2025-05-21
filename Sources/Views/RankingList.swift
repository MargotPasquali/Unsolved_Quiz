//
//  RankingList.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//
//

import SwiftUI

struct RankingList: View {
    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()

            VStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color.violet)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                    HStack {
                        Text("player_name_title")
                            .foregroundStyle(Color.lightGray)
                            .font(Font.custom("Dongle-Bold", size: 32))
                            .padding(.leading, 20)

                        Spacer()

                        Text("Score_text_title")
                            .foregroundStyle(Color.lightGray)
                            .font(Font.custom("Dongle-Bold", size: 32))
                            .padding(.trailing, 20)
                    }
                }
                
                ZStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.violet, lineWidth: 4)
                            .padding(-1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.bottom, 15)
                        
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
            }.padding(.horizontal, 20)
        }
    }
}

#Preview {
    RankingList()
}
