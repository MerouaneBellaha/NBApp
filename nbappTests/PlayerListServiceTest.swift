//
//  PlayerListServiceTest.swift
//  nbappTests
//
//  Created by Merouane Bellaha on 05/02/2022.
//

import XCTest
@testable import nbapp

final class PlayerListServiceTest: XCTestCase {
    
    private var service: PlayerListService!
    private var result: (data: [String: [Player]]?, error: RequestError?)
    private var nbaApiMock = NbaApiMock()
     
    override func setUp() {
        service = PlayerListService(nbaApi: nbaApiMock)
    }
    
    override func tearDown() {
        service = nil
    }
    
    func testGivenApiResultIsFailure_WhenFetchPlayers_ThenShouldFailWithRequestErrorDotError() {
        
        nbaApiMock.result = .failure(.error)
        
        service.fetchPlayers { result in
            switch result {
            case .failure(let error): self.result = (nil, error)
            case .success(let players): self.result = (players, nil)
            }
        }
        
        XCTAssertNil(result.data)
        XCTAssertEqual(result.error?.description, RequestError.error.description)
    }
    
    func testGiventApiResultIsSuccess_WhenFetchPlayers_ThenShoulSucceed () {
        
        nbaApiMock.result = .success([PlayerModel(id: 0, first_name: "ok", last_name: "okok")])
        
        service.fetchPlayers { result in
            switch result {
            case .failure(let error): self.result = (nil, error)
            case .success(let players): self.result = (players, nil)
            }
        }

        XCTAssertNil(result.error)
        XCTAssertEqual((result.data ?? [:]), ["o": [Player(playerModel: PlayerModel(id: 0, first_name: "ok", last_name: "okok"))]])
    }
}
