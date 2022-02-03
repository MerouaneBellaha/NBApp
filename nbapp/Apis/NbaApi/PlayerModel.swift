//
//  PlayerModel.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

struct PlayerData: Decodable {
    var data: [PlayerModel]
}

struct PlayerModel: Decodable {
    var id: Int
    var first_name: String
    var last_name: String
}
