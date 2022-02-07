//
//  PlayerListViewModelTest.swift
//  nbappTests
//
//  Created by Merouane Bellaha on 05/02/2022.
//

import XCTest
@testable import nbapp

class PlayerListViewModelTest: XCTestCase {
    
    private var viewModel: PlayerListViewModel!
    private var service = PlayerListServiceMock()
    
    override func setUp() {
        viewModel = PlayerListViewModel(service: service)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    // MARK: - fetchPlayers()
    
    func testGivenServiceResultIsFailure_WhenFetchPlayers_ThenShouldFailWithRequestErrorDotErrorAndUpdateErrorDescription() {
        service.result = .failure(.error)
        
        viewModel.fetchPlayers()
        
        let expectation = expectation(description: "expectaction")

        DispatchQueue.main.async { [self] in
            XCTAssertTrue(viewModel.showAlert)
            XCTAssertEqual(viewModel.errorDescription, RequestError.error.description)
            XCTAssertTrue(viewModel.players.isEmpty)
            XCTAssertTrue(viewModel.playersFirstLetters.isEmpty)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGiventServiceResultIsSuccess_WhenFetchPlayers_ThenShoulSucceedAndUpdtatePlayers () {
        
        service.result = .success(["o": [Player(playerModel: PlayerModel(id: 0, first_name: "ok", last_name: "okok"))]])
        
        viewModel.fetchPlayers()
        
        let expectation = expectation(description: "expectaction")
        
        DispatchQueue.main.async { [self] in
            XCTAssertFalse(viewModel.showAlert)
            XCTAssertNil(viewModel.errorDescription)
            XCTAssertEqual(viewModel.players, ["o": [Player(playerModel: PlayerModel(id: 0, first_name: "ok", last_name: "okok"))]])
            XCTAssertEqual(viewModel.playersFirstLetters, ["o"])
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - getPlayersForKey
    
    func testGivenLetterDoesntExistInPlayers_WhenGetPlayerForKey_ThenShouldReturnEmptyArray() {
        
        viewModel.players = ["o": [Player(playerModel: PlayerModel(id: 0, first_name: "ok", last_name: "okok"))]]
        
        let result = viewModel.getPlayersForKey("u")
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGivenLetterExistInPlayers_WhenGetPlayerForKey_ThenShouldReturnValueForKey() {
        
        viewModel.players = ["o": [Player(playerModel: PlayerModel(id: 0, first_name: "ok", last_name: "okok"))]]
        
        let result = viewModel.getPlayersForKey("o")
        
        XCTAssertEqual(result, [Player(playerModel: PlayerModel(id: 0, first_name: "ok", last_name: "okok"))])
    }
    
    
}

class PlayerListServiceMock: PlayerListServiceInterface {
    
    var result: Result<[String : [Player]], RequestError>? = nil
    
    func fetchPlayers(completion: @escaping ((Result<[String : [Player]], RequestError>) -> Void)) {
        guard let result = result else { return }
        switch result {
        case .success(let players): completion(.success(players))
        case .failure: completion(.failure(.error))
        }
    }
}
