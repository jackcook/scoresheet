//
//  GameViewController.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ScoreCardViewDelegate, CourtInputViewDelegate, ResultSelectorViewDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var scoreCard: ScoreCardView!
    @IBOutlet weak var courtView: CourtInputView!
    @IBOutlet weak var resultSelector: ResultSelectorView!
    
    @IBOutlet weak var playerOneServeSwitch: UISwitch!
    @IBOutlet weak var playerOneServeLabel: UILabel!
    @IBOutlet weak var playerTwoServeSwitch: UISwitch!
    @IBOutlet weak var playerTwoServeLabel: UILabel!
    
    @IBOutlet weak var playerOneWinSwitch: UISwitch!
    @IBOutlet weak var playerOneWinLabel: UILabel!
    @IBOutlet weak var playerTwoWinSwitch: UISwitch!
    @IBOutlet weak var playerTwoWinLabel: UILabel!
    
    var game: Game!
    
    private var currentPoint: Point {
        return game.points[scoreCard.selectedIndex]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setImage(backButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .white
        
        if game == nil {
            game = Game()
        }
        
        scoreCard.game = game
        scoreCard.scoreCardDelegate = self
        
        courtView.delegate = self
        courtView.shots = game.points[0].shots
        
        resultSelector.delegate = self
        resultSelector.load(point: game.points[0])
        
        playerOneServeLabel.text = game.playerOne.name
        playerTwoServeLabel.text = game.playerTwo.name
        playerOneWinLabel.text = game.playerOne.name
        playerTwoWinLabel.text = game.playerTwo.name
        
        navigationItem.title = "\(game.playerOne.name) vs. \(game.playerTwo.name)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _ = scoreCard.resignFirstResponder()
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
        
        scoreCard.game.save()
    }
    
    @IBAction func playerOneServeToggled(_ sender: UISwitch) {
        playerTwoServeSwitch.setOn(!playerOneServeSwitch.isOn, animated: true)
        
        game.points[scoreCard.selectedIndex].serverId = playerOneServeSwitch.isOn ? 1 : 2
    }
    
    @IBAction func playerTwoServeToggled(_ sender: UISwitch) {
        playerOneServeSwitch.setOn(!playerTwoServeSwitch.isOn, animated: true)
        
        game.points[scoreCard.selectedIndex].serverId = playerTwoServeSwitch.isOn ? 2 : 1
    }
    
    @IBAction func playerOneWinToggled(_ sender: UISwitch) {
        if sender.isOn {
            playerTwoWinSwitch.setOn(false, animated: true)
            
            if scoreCard.selectedIndex == game.points.count - 1 && currentPoint.winnerId == 0 {
                let point = Point(result: .unknown, serverId: 1, shots: [Shot](), winnerId: 0)
                game.points.append(point)
            }
            
            game.points[scoreCard.selectedIndex].winnerId = 1
        } else {
            game.points[scoreCard.selectedIndex].winnerId = 0
        }
        
        scoreCard.updatePoint(point: currentPoint)
    }
    
    @IBAction func playerTwoWinToggled(_ sender: UISwitch) {
        if sender.isOn {
            playerOneWinSwitch.setOn(false, animated: true)
            
            if scoreCard.selectedIndex == game.points.count - 1 && currentPoint.winnerId == 0 {
                let point = Point(result: .unknown, serverId: 2, shots: [Shot](), winnerId: 0)
                game.points.append(point)
            }
            
            game.points[scoreCard.selectedIndex].winnerId = 2
        } else {
            game.points[scoreCard.selectedIndex].winnerId = 0
        }
        
        scoreCard.updatePoint(point: currentPoint)
    }
    
    func selected(scoreCard: ScoreCardView, shot: Int) {
        playerOneServeSwitch.setOn(currentPoint.serverId == 1, animated: false)
        playerTwoServeSwitch.setOn(currentPoint.serverId == 2, animated: false)
        playerOneWinSwitch.setOn(currentPoint.winnerId == 1, animated: false)
        playerTwoWinSwitch.setOn(currentPoint.winnerId == 2, animated: false)
        
        courtView.shots = game.points[shot].shots
        resultSelector.load(point: game.points[shot])
    }
    
    func recordedShot(shot: Shot) {
        game.points[scoreCard.selectedIndex].shots.append(shot)
        courtView.shots = currentPoint.shots
    }
    
    func resultSelector(_ selectorView: ResultSelectorView, selectedResult result: PointResult) {
        game.points[scoreCard.selectedIndex].result = result
    }
}
