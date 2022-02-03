//
//  PlayerListViewModel.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

class PlayerListViewModel: ObservableObject {

    @Published var players: [Player] = []
    @Published var showAlert: Bool = false

    private let service: PlayerListService

    var errorDescription: String?

    init(service: PlayerListService = PlayerListService()) {
        self.service = service
    }

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
}
