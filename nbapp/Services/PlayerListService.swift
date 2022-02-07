//
//  PlayerListService.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

protocol PlayerListServiceInterface {
    func fetchPlayers(completion: @escaping ((Result<[String: [Player]], RequestError>) -> Void))
}

struct PlayerListService: PlayerListServiceInterface {

    // MARK: - Private Properties
    
    private var nbaApi: NbaApiProtocol
    
    // MARK: - Init

    init(nbaApi: NbaApiProtocol = NbaApi()) {
        self.nbaApi = nbaApi
    }
    
    // MARK: - Public Methods

    func fetchPlayers(completion: @escaping ((Result<[String: [Player]], RequestError>) -> Void)) {
        nbaApi.fetchPlayers { result in
            switch result {
            case .failure(let _) :
                completion(.failure(.error))
            case .success(let players) :
                let players = players
                    .compactMap { Player(playerModel: $0) }
                    .groupedByFirstLetter()
                completion(.success(players))
            }
        }
    }
}

// MARK: - Array<Player> Extension

extension Array where Element == Player {
    
    /// group Player by their first name first letter
    func groupedByFirstLetter() -> [String: [Player]] {
        let sortedSelf = self.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
        return Dictionary(grouping: sortedSelf, by: { String($0.firstName.first!) })
    }
}
