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
    var serverId: Int
    var shots: [Shot]
    var winnerId: Int
    
    var object: [String: Any] {
        var shotsData = [[String: Float]]()
        
        for shot in shots {
            shotsData.append(shot.object)
        }
        
        var data = [
            "result": result.rawValue,
            "shots": shotsData
        ] as [String: Any]
        
        data["serverId"] = serverId
        data["winnerId"] = winnerId
        
        return data
    }
    
    init?(data: [String: Any]) {
        if let result = data["result"] as? Int {
            self.result = PointResult(rawValue: result) ?? .unknown
        } else {
            return nil
        }
        
        if let serverId = data["serverId"] as? Int {
            self.serverId = serverId
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
        
        if let winnerId = data["winnerId"] as? Int {
            self.winnerId = winnerId
        } else {
            return nil
        }
    }
    
    init() {
        result = .unknown
        serverId = 1
        shots = [Shot]()
        winnerId = 0
    }
    
    init(result: PointResult, serverId: Int, shots: [Shot], winnerId: Int) {
        self.result = result
        self.serverId = serverId
        self.shots = shots
        self.winnerId = winnerId
    }
}
