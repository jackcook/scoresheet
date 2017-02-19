//
//  Game.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import Foundation

struct Game {
    
    var playerOne: Player
    var playerTwo: Player
    var points: [Point]
    
    init?(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "game"),
            let data = NSDictionary(contentsOfFile: path),
            let playerOne = data["playerOne"] as? String,
            let playerTwo = data["playerTwo"] as? String,
            let points = data["points"] as? [[String: Any]] {
            
            self.playerOne = Player(name: playerOne)
            self.playerTwo = Player(name: playerTwo)
            
            self.points = [Point]()
            
            for point in points {
                if let pointObject = Point(data: point) {
                    self.points.append(pointObject)
                } else {
                    return nil
                }
            }
        } else {
            return nil
        }
    }
    
    init(playerOne: Player, playerTwo: Player, points: [Point]) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.points = points
    }
    
    func save() {
        var pointsData = [[String: Any]]()
        
        for point in points {
            pointsData.append(point.object)
        }
        
        let data = [
            "playerOne": playerOne.name,
            "playerTwo": playerTwo.name,
            "points": pointsData
        ] as NSDictionary
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = "\(documentsDirectory)\(UUID().uuidString).game"
        print(path)
        
        data.write(toFile: path, atomically: true)
    }
}
