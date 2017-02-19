//
//  Game.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import Foundation

struct Game {
    
    var id: String
    var playerOne: Player
    var playerTwo: Player
    var points: [Point]
    
    init?(filePath: String) {
        id = NSString(string: NSString(string: filePath).lastPathComponent).deletingPathExtension
        
        if let data = NSDictionary(contentsOfFile: filePath),
            let playerOne = data["playerOne"] as? String,
            let playerTwo = data["playerTwo"] as? String,
            let points = data["points"] as? [[String: Any]] {
            
            self.playerOne = Player(position: .first, name: playerOne)
            self.playerTwo = Player(position: .second, name: playerTwo)
            
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
    
    init() {
        self.id = UUID().uuidString
        self.playerOne = Player(position: .first, name: "Player One")
        self.playerTwo = Player(position: .second, name: "Player Two")
        self.points = [Point()]
    }
    
    init(playerOne: Player, playerTwo: Player, points: [Point]) {
        self.id = UUID().uuidString
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
            "playerOne": playerOne.name ?? "Player One",
            "playerTwo": playerTwo.name ?? "Player Two",
            "points": pointsData
        ] as NSDictionary
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = "\(documentsDirectory)/\(id).game"
        
        data.write(toFile: path, atomically: true)
    }
}
