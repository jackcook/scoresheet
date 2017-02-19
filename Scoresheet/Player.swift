//
//  Player.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

struct Player: Equatable {
    var position: PlayerPosition
    var name: String?
}

enum PlayerPosition: Int {
    case unknown = 0, first, second
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.position == rhs.position
}
