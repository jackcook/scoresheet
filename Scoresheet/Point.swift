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
    var server: PlayerPosition
    var shots: [Shot]
    var winner: PlayerPosition
    
    var object: [String: Any] {
        var shotsData = [[String: Float]]()
        
        for shot in shots {
            shotsData.append(shot.object)
        }
        
        var data = [
            "result": result.rawValue,
            "shots": shotsData
        ] as [String: Any]
        
        data["server"] = server.rawValue
        data["winner"] = winner.rawValue
        
        return data
    }
    
    init?(data: [String: Any]) {
        if let result = data["result"] as? Int {
            self.result = PointResult(rawValue: result) ?? .unknown
        } else {
            return nil
        }
        
        if let server = data["server"] as? Int {
            self.server = PlayerPosition(rawValue: server) ?? .unknown
        } else {
            return nil
        }
        
        if let shots = data["shots"] as? [[String: Float]] {
            self.shots = [Shot]()
            
            for shot in shots {
                self.shots.append(Shot(data: shot))
            }
        } else {
            return nil
        }
        
        if let winner = data["winner"] as? Int {
            self.winner = PlayerPosition(rawValue: winner) ?? .unknown
        } else {
            return nil
        }
    }
    
    init() {
        result = .unknown
        server = .first
        shots = [Shot]()
        winner = .unknown
    }
    
    init(result: PointResult, server: PlayerPosition, shots: [Shot], winner: PlayerPosition) {
        self.result = result
        self.server = server
        self.shots = shots
        self.winner = winner
    }
}
