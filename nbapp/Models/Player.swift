//
//  Player.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

struct Player: Identifiable {
    var id: Int
    var firtsName: String
    var lastName: String

    init(playerModel: PlayerModel) {
        self.id = playerModel.id
        self.firtsName = playerModel.first_name
        self.lastName = playerModel.last_name
    }
}
