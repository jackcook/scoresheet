//
//  Player.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

struct Player: Equatable {
    var id: Int
    var name: String?
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.id == rhs.id
}
