//
//  StartNewGameViewModel.swift
//  Unsolved
//
//  Created by Margot Pasquali on 15/05/2025.
//

import Foundation

final class StartNewGameViewModel: ObservableObject {
    
    // MARK: - Error handling
    enum StartNewGameViewModelError : Error {
        case usernameEmpty
        case setUsernameFailed
        
        
        var localizedDescription: String {
            switch self {
            case .usernameEmpty:
                return "The username cannot be empty"
            case .setUsernameFailed:
                return "Failed to set username"
            }
        }
    }
    
    // MARK: - Constants
    private let playerDataService: PlayerDataService
    
    // MARK: - Properties
    @Published var username: String = ""
    var errorMessage: String?
    
    // MARK: - Init
    init(playerDataService: PlayerDataService = RemotePlayerDataService()) {
        self.playerDataService = playerDataService
    }
    
    // MARK: - Functions
    func setUsername(username: String) async {
        
        guard !username.isEmpty else {
            errorMessage = StartNewGameViewModelError.usernameEmpty.localizedDescription
            return
        }
        
        do {
            try await playerDataService.saveUsername(username)
            self.username = username
        } catch {
            errorMessage = StartNewGameViewModelError.setUsernameFailed.localizedDescription
            return
        }
    }
}



