//
//  PlayerListService.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

struct PlayerListService {

    private var nbaApi: NbaApi

    init(nbaApi: NbaApi = NbaApi()) {
        self.nbaApi = nbaApi
    }

    func fetchPlayers(completion: @escaping ((Result<[Player], RequestError>) -> Void)) {
        nbaApi.fetchPlayers { result in
            switch result {
            case .failure(let error) :
                print("ook")
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
