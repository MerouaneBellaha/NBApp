//
//  HTTPErrors.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

enum RequestError: Error {
    case noData, incorrectResponse, undecodableData, error, urlError
    
    var description: String {
        switch self {
        case .noData:
            return "No data."
        case .incorrectResponse:
            return "Incorrect response"
        case .undecodableData:
            return "Undecodable data"
        case .urlError:
            return "Url error"
        case .error:
            return "Error"
        }
    }
}
