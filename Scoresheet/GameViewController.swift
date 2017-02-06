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
    
    private var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = Player(name: "Angela Chou")
        let p2 = Player(name: "Tai Tzu-ying")
        let firstPoint = Point(result: .unknown, server: p1, shots: [Shot](), winner: nil)
        game = Game(playerOne: p1, playerTwo: p2, points: [firstPoint])
        
        scoreCard.game = game
        scoreCard.scoreCardDelegate = self
        
        shotSelector.delegate = self
        
        resultSelector.delegate = self
        resultSelector.playerOne = game.playerOne
        resultSelector.playerTwo = game.playerTwo
    }
    
    func selected(scoreCard: ScoreCardView, shot: Int) {
        resultSelector.load(point: game.points[shot])
    }
    
    func shotSelector(selector: ShotSelectorView, shotSelected shot: String) {
//        shotsLabel.text = (shotsLabel.text ?? "") + shot + " "
    }
    
    func resultSelector(_ selectorView: ResultSelectorView, selectedWinner winner: Player, withResult result: PointResult) {
        game.points[scoreCard.selectedIndex].result = result
        game.points[scoreCard.selectedIndex].winner = winner
        
        if scoreCard.selectedIndex == game.points.count - 1 {
            let point = Point(result: .unknown, server: winner, shots: [Shot](), winner: nil)
            game.points.append(point)
        }
        
        scoreCard.updatePoint(point: game.points[scoreCard.selectedIndex])
    }
}
