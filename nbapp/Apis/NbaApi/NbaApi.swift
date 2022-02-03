//
//  NbaApi.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

final class NbaApi {
    
    private let url = URL(string: "https://free-nba.p.rapidapi.com/players")
    private var httpClient = HTTPClient()
    private let batchSize = 100
    private let httpHeaders = [
        ("x-rapidapi-host", "free-nba.p.rapidapi.com"),
        ("x-rapidapi-key", "6cc884bd28msh7d072d129539379p1e2a11jsn6493c0f5e460")
    ]
    
    func fetchPlayers(completion: @escaping ((Result<[PlayerModel], RequestError>) -> Void)) {
        guard let url = url else {
            completion(.failure(.urlError))
            return
        }
        
        var players: [PlayerModel] = []
        var lastBatchSize: Int = 0
        var pagination: Int = 0
        var parameters: [(String, Int)] {[
            ("page", pagination),
            ("per_page", 100)
        ]}
        
        
        var isOnError: Bool = false
        let dispatchGroup = DispatchGroup()
        
        repeat {
            dispatchGroup.enter()
            
            httpClient.request(url: url,
                               parameters: parameters,
                               httpHeaders: httpHeaders)
            { (result: Result<PlayerData, RequestError>) in
                switch result {
                case .failure(let error):
                    isOnError = true
                    dispatchGroup.leave()
                case .success(let playersData):
                    lastBatchSize = playersData.data.count
                    pagination += 1
                    players += playersData.data
                    dispatchGroup.leave()
                }
            }
        } while lastBatchSize == batchSize
        
        dispatchGroup.notify(queue: .main) {
            if isOnError {
                completion(.failure(.error))
            } else {
                completion(.success(players))
            }
        }
    }
}
