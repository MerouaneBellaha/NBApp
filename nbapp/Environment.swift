//
//  Environment.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation


// Should be secret / injected in real life project

struct Environment {
    struct Api {
        struct Nba {
            static let url = "https://free-nba.p.rapidapi.com/players"
            
            static let apiHostKey = "x-rapidapi-host"
            static let apiHostValue = "free-nba.p.rapidapi.com"
            
            static let apiKeyKey = "x-rapidapi-key"
            static let apiKeyValue = "6cc884bd28msh7d072d129539379p1e2a11jsn6493c0f5e460"
            
            static let paginationParameterKey = "page"
            static let batchSizeParameterKey = "per_page"
        }
    }
}
