//
//  PlayerListService.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

struct PlayerListService {

    // MARK: - Private Properties
    
    private var nbaApi: NbaApi
    
    // MARK: - Init

    init(nbaApi: NbaApi = NbaApi()) {
        self.nbaApi = nbaApi
    }
    
    // MARK: - Public Methods

    func fetchPlayers(completion: @escaping ((Result<[Player], RequestError>) -> Void)) {
        nbaApi.fetchPlayers { result in
            switch result {
            case .failure(let error) :
                completion(.failure(.error))
            case .success(let players) :
                let players = players
                    .compactMap { Player(playerModel: $0) }
                    .sorted { $0.firtsName.lowercased() < $1.firtsName.lowercased() }
                completion(.success(players))
            }
        }
    }
}
