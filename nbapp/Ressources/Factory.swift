//
//  Factory.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import Foundation

#if DEBUG
struct Factory {

    static func createPlayersGroupedByFirstName() -> [String: [Player]] {
        let names = ["Noah","Emma","Liam","Olivia","Oliver","Ava","Elijah","Charlotte","William","Alexander",
                     "Sophia","James","Amelia","Benjamin","Isabella","Lucas","Mia","Henry","Evelyn","Harper"]
        var randomInt: Int { Int.random(in: 0..<names.count) }
        
        return (0...10)
            .map { PlayerModel(id: $0, first_name: names[randomInt], last_name: names[randomInt]) }
            .compactMap { Player(playerModel: $0) }
            .groupedByFirstLetter()
    }
}
#endif
