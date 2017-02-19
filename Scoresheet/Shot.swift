//
//  Shot.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

struct Shot {
    
    var x: Float
    var y: Float
    
    var object: [String: Float] {
        return [
            "x": x,
            "y": y
        ]
    }
    
    init(data: [String: Float]) {
        x = data["x"] ?? 0
        y = data["y"] ?? 0
    }
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
}
