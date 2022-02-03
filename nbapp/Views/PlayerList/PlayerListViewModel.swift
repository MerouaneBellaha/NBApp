//
//  PlayerListViewModel.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

final class PlayerListViewModel: ObservableObject {
    
    // MARK: - Published Properties

    @Published var players: [String: [Player]] = [:]
    @Published var showAlert: Bool = false
    
    // MARK: - Private Properties

    private let service: PlayerListService
    
    // MARK: - Public Properties

    var errorDescription: String?
    var playersFirstLetters: [String] { players.keys.sorted() }
    
    // MARK: - Init

    init(service: PlayerListService = PlayerListService()) {
        self.service = service
    }
    
    // MARK: - Public Methods

    func fetchPlayers() {
        service.fetchPlayers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error) :
                DispatchQueue.main.async {
                    self.showAlert.toggle()
                    self.errorDescription = error.description
                }
            case .success(let players) :
                DispatchQueue.main.async {
                    self.players = players
                }
            }
        }
    }
   
    func getPlayersForKey(_ letter: String) -> [Player] {
        guard let players = players[letter] else {
            return []
        }
        return players
    }
}
