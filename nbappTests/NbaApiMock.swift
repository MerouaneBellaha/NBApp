//
//  NbaApiMock.swift
//  nbappTests
//
//  Created by Merouane Bellaha on 07/02/2022.
//

@testable import nbapp

final class NbaApiMock: NbaApiProtocol {

    var result: Result<[PlayerModel], RequestError>? = nil

    func fetchPlayers(completion: @escaping ((Result<[PlayerModel], RequestError>) -> Void)) {
        guard let result = result else { return }
        switch result {
        case .success(let players): completion(.success(players))
        case .failure: completion(.failure(.error))
        }
    }
}
