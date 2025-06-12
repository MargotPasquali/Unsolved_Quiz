//
//  EndGameViewModel.swift
//  Unsolved
//
//  Created by Margot Pasquali on 15/05/2025.
//

import Foundation
import Combine

@MainActor
final class EndGameViewModel: ObservableObject {
    
    enum EndGameViewModelError: Error {
        case noData
        case savingFailed
        
        var localizedDescription: String {
            switch self {
            case .noData:
                return "No data available"
            case .savingFailed:
                return "Saving failed"
            }
        }
    }
    
    @Published private(set) var playerScores: [PlayerScore] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    private let playerDataService: PlayerDataService
    
    init(playerDataService: PlayerDataService = RemotePlayerDataService()) {
        self.playerDataService = playerDataService
    }
    
    func fetchRankingList() async {
        isLoading = true
        errorMessage = nil
        do {
            playerScores = try await playerDataService.fetchPlayerScores()
        } catch {
            errorMessage = EndGameViewModelError.noData.localizedDescription
        }
        isLoading = false
    }
    
    func saveScore(username: String, score: Int) async {
            do {
                try await playerDataService.savePlayerScore(username: username, score: score)
            } catch {
                errorMessage = EndGameViewModelError.savingFailed.localizedDescription
            }
        }
}
