//
//  GameViewController.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ScoreCardViewDelegate, ShotSelectorViewDelegate, ResultSelectorViewDelegate {
    
    @IBOutlet weak var scoreCard: ScoreCardView!
    @IBOutlet weak var shotSelector: ShotSelectorView!
    @IBOutlet weak var resultSelector: ResultSelectorView!
    @IBOutlet weak var displayTable: ShotDisplayTableView!
    
    @IBOutlet weak var playerOneServeSwitch: UISwitch!
    @IBOutlet weak var playerOneServeLabel: UILabel!
    @IBOutlet weak var playerTwoServeSwitch: UISwitch!
    @IBOutlet weak var playerTwoServeLabel: UILabel!
    
    @IBOutlet weak var playerOneWinSwitch: UISwitch!
    @IBOutlet weak var playerOneWinLabel: UILabel!
    @IBOutlet weak var playerTwoWinSwitch: UISwitch!
    @IBOutlet weak var playerTwoWinLabel: UILabel!
    
    private var game: Game!
    
    private var currentPoint: Point {
        return game.points[scoreCard.selectedIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = Player(name: "Carolina Marin")
        let p2 = Player(name: "Tai Tzu-ying")
        let firstPoint = Point(result: .unknown, server: nil, shots: [Shot](), winner: nil)
        game = Game(playerOne: p1, playerTwo: p2, points: [firstPoint])
        
        scoreCard.game = game
        scoreCard.scoreCardDelegate = self
        
        shotSelector.delegate = self
        resultSelector.delegate = self
        
        displayTable.server = p1
        displayTable.opponent = p2
        
        playerOneServeLabel.text = game.playerOne.name
        playerTwoServeLabel.text = game.playerTwo.name
        playerOneWinLabel.text = game.playerOne.name
        playerTwoWinLabel.text = game.playerTwo.name
    }
    
    @IBAction func playerOneServeToggled(_ sender: UISwitch) {
        playerTwoServeSwitch.setOn(!playerOneServeSwitch.isOn, animated: true)
        
        displayTable.server = playerOneServeSwitch.isOn ? game.playerOne : game.playerTwo
        displayTable.opponent = playerTwoServeSwitch.isOn ? game.playerOne : game.playerTwo
        
        game.points[scoreCard.selectedIndex].server = playerOneServeSwitch.isOn ? game.playerOne : game.playerTwo
    }
    
    @IBAction func playerTwoServeToggled(_ sender: UISwitch) {
        playerOneServeSwitch.setOn(!playerTwoServeSwitch.isOn, animated: true)
        
        displayTable.server = playerOneServeSwitch.isOn ? game.playerOne : game.playerTwo
        displayTable.opponent = playerTwoServeSwitch.isOn ? game.playerOne : game.playerTwo
        
        game.points[scoreCard.selectedIndex].server = playerTwoServeSwitch.isOn ? game.playerTwo : game.playerOne
    }
    
    @IBAction func playerOneWinToggled(_ sender: UISwitch) {
        if sender.isOn {
            playerTwoWinSwitch.setOn(false, animated: true)
            
            if scoreCard.selectedIndex == game.points.count - 1 && currentPoint.winner == nil {
                let point = Point(result: .unknown, server: game.playerOne, shots: [Shot](), winner: nil)
                game.points.append(point)
            }
            
            game.points[scoreCard.selectedIndex].winner = game.playerOne
        } else {
            game.points[scoreCard.selectedIndex].winner = nil
        }
        
        scoreCard.updatePoint(point: currentPoint)
    }
    
    @IBAction func playerTwoWinToggled(_ sender: UISwitch) {
        if sender.isOn {
            playerOneWinSwitch.setOn(false, animated: true)
            
            if scoreCard.selectedIndex == game.points.count - 1 && currentPoint.winner == nil {
                let point = Point(result: .unknown, server: game.playerTwo, shots: [Shot](), winner: nil)
                game.points.append(point)
            }
            
            game.points[scoreCard.selectedIndex].winner = game.playerTwo
        } else {
            game.points[scoreCard.selectedIndex].winner = nil
        }
        
        scoreCard.updatePoint(point: currentPoint)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        game.points[scoreCard.selectedIndex].shots = [Shot]()
        displayTable.shots = game.points[scoreCard.selectedIndex].shots
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if let selectedIndex = displayTable.indexPathForSelectedRow {
            game.points[scoreCard.selectedIndex].shots.remove(at: selectedIndex.row)
            displayTable.shots = game.points[scoreCard.selectedIndex].shots
        }
    }
    
    func selected(scoreCard: ScoreCardView, shot: Int) {
        playerOneServeSwitch.setOn(currentPoint.server == game.playerOne, animated: false)
        playerTwoServeSwitch.setOn(currentPoint.server == game.playerTwo, animated: false)
        playerOneWinSwitch.setOn(currentPoint.winner == game.playerOne, animated: false)
        playerTwoWinSwitch.setOn(currentPoint.winner == game.playerTwo, animated: false)
        
        resultSelector.load(point: game.points[shot])
        displayTable.shots = currentPoint.shots
    }
    
    func shotSelector(selector: ShotSelectorView, shotSelected shot: Shot) {
        game.points[scoreCard.selectedIndex].shots.append(shot)
        displayTable.shots = currentPoint.shots
    }
    
    func resultSelector(_ selectorView: ResultSelectorView, selectedResult result: PointResult) {
        game.points[scoreCard.selectedIndex].result = result
    }
}
