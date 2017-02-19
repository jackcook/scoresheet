//
//  Point.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import Foundation

struct Point {
    
    var result: PointResult
    var server: Player?
    var shots: [Shot]
    var winner: Player?
    
    var object: [String: Any] {
        var shotsData = [[String: Float]]()
        
        for shot in shots {
            shotsData.append(shot.object)
        }
        
        var data = [
            "result": result.rawValue,
            "shots": shotsData
        ] as [String: Any]
        
        if let server = server {
            data["server"] = server.name
        }
        
        if let winner = winner {
            data["winner"] = winner.name
        }
        
        return data
    }
    
    init?(data: [String: Any]) {
        if let result = data["result"] as? Int {
            self.result = PointResult(rawValue: result) ?? .unknown
        } else {
            return nil
        }
        
        if let server = data["server"] as? String {
            self.server = Player(name: server)
        }
        
        if let shots = data["shots"] as? [[String: Float]] {
            self.shots = [Shot]()
            
            for shot in shots {
                self.shots.append(Shot(data: shot))
            }
        } else {
            return nil
        }
        
        if let winner = data["winner"] as? String {
            self.winner = Player(name: winner)
        }
    }
    
    init(result: PointResult, server: Player?, shots: [Shot], winner: Player?) {
        self.result = result
        self.server = server
        self.shots = shots
        self.winner = winner
    }
}
