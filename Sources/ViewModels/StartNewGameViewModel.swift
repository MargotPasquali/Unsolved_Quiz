//
//  StartNewGameViewModel.swift
//  Unsolved
//
//  Created by Margot Pasquali on 15/05/2025.
//

import Foundation

final class StartNewGameViewModel: ObservableObject {
    enum StartNewGameViewModelError: Error {
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
    
    private let playerDataService: PlayerDataService
    @Published var username: String = ""
    @Published var isLoading = false
    var errorMessage: String?
    
    init(playerDataService: PlayerDataService = RemotePlayerDataService()) {
        self.playerDataService = playerDataService
    }
    
    func setUsername(username: String) async {
        print("Tentative de définir le nom d'utilisateur: \(username)")
        Task { @MainActor in isLoading = true }
        
        guard !username.isEmpty else {
            print("Erreur: le nom d'utilisateur est vide")
            Task { @MainActor in
                errorMessage = StartNewGameViewModelError.usernameEmpty.localizedDescription
                isLoading = false
            }
            return
        }
        
        do {
            try await playerDataService.saveUsername(username)
            print("Nom d'utilisateur défini avec succès: \(username)")
            Task { @MainActor in
                self.username = username
                isLoading = false
            }
        } catch {
            print("Erreur lors de la définition du nom d'utilisateur: \(error.localizedDescription)")
            Task { @MainActor in
                errorMessage = StartNewGameViewModelError.setUsernameFailed.localizedDescription
                isLoading = false
            }
        }
    }
}
