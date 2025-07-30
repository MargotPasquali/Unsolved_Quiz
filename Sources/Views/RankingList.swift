//
//  RankingList.swift
//  Unsolved
//
//  Created by Margot Pasquali on 09/05/2025.
//
//

import SwiftUI

struct RankingList: View {
    @ObservedObject var viewModel: EndGameViewModel

    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()

            VStack(spacing: 15) {

                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color.red)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                    HStack {
                        Text("player_name_title")
                            .foregroundStyle(Color.gray)
                            .font(Font.custom("BeVietnamPro-SemiBold", size: 32))
                            .padding(.leading, 20)

                        Spacer()

                        Text("Score_text_title")
                            .foregroundStyle(Color.gray)
                            .font(Font.custom("BeVietnamPro-SemiBold", size: 32))
                            .padding(.trailing, 20)
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(Array(viewModel.playerScores.enumerated()), id: \.element.id) { index, playerScore in
                                if index % 2 == 0 {
                                    RankingListRowView1(playerName: playerScore.playerName, score: playerScore.score)
                                } else {
                                    RankingListRowView2(playerName: playerScore.playerName, score: playerScore.score)
                                }
                            }
                        }
                    }
                }

                NavigationLink(destination: StartNewGameView(viewModel: StartNewGameViewModel())) {
                    Text("replay_button")
                        .frame(width: 350, height: 50)
                        .padding(5)
                        .background(Color.blue)
                        .font(Font.custom("BeVietnamPro-SemiBold", size: 40))
                        .foregroundStyle(Color.gray)
                        .cornerRadius(19)
                }
            }
            .padding(.horizontal, 20)
            .task {
                await viewModel.fetchRankingList()
            }
        }
    }
}

#Preview {
    RankingList(viewModel: EndGameViewModel())
}
