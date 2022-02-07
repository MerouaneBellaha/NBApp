//
//  NbaApi.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

protocol NbaApiProtocol {
    func fetchPlayers(completion: @escaping ((Result<[PlayerModel], RequestError>) -> Void))
}

final class NbaApi: NbaApiProtocol {
    
    // MARK: - Private Properties
    
    private let url = URL(string: Environment.Api.Nba.url)
    private var httpClient = HTTPClient()
    private let batchSize = 100
    private let httpHeaders = [
        (Environment.Api.Nba.apiHostKey, Environment.Api.Nba.apiHostValue),
        (Environment.Api.Nba.apiKeyKey, Environment.Api.Nba.apiKeyValue)
    ]
    
    // MARK: - Public Methods
    
    func fetchPlayers(completion: @escaping ((Result<[PlayerModel], RequestError>) -> Void)) {
        guard let url = url else {
            completion(.failure(.urlError))
            return
        }
        
        var players: [PlayerModel] = []
        var lastBatchSize: Int = 0
        var pagination: Int = 0
        var parameters: [(String, Int)] {[
            (Environment.Api.Nba.paginationParameterKey, pagination),
            (Environment.Api.Nba.batchSizeParameterKey, 100)
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
                case .failure(let _):
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
