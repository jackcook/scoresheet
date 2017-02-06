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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreCard.scoreCardDelegate = self
        shotSelector.delegate = self
        resultSelector.delegate = self
    }
    
    func selected(scoreCard: ScoreCardView, shot: Int) {
        resultSelector.reset()
    }
    
    func shotSelector(selector: ShotSelectorView, shotSelected shot: String) {
//        shotsLabel.text = (shotsLabel.text ?? "") + shot + " "
    }
    
    func selectedWinner(resultSelector: ResultSelectorView, playerOne: Bool) {
        scoreCard.selectPointWinner(playerOne: playerOne)
    }
}
