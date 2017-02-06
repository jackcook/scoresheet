//
//  ResultSelectorView.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ResultSelectorView: UIView {
    
    var delegate: ResultSelectorViewDelegate?
    
    var playerOne: Player! {
        didSet {
            playerOneButton.setTitle(playerOne.name, for: .normal)
        }
    }
    
    var playerTwo: Player! {
        didSet {
            playerTwoButton.setTitle(playerTwo.name, for: .normal)
        }
    }
    
    private var playerOneButton: UIButton!
    private var playerTwoButton: UIButton!
    private var couldntReachButton: UIButton!
    private var hitNetButton: UIButton!
    private var hitOutButton: UIButton!
    private var leftInButton: UIButton!
    
    private var winner: Player?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 2
        
        playerOneButton = UIButton(type: .system)
        playerOneButton.addTarget(self, action: #selector(playerOneButtonPressed(sender:)), for: .touchUpInside)
        playerOneButton.layer.borderColor = UIColor.border.cgColor
        playerOneButton.layer.borderWidth = 1
        playerOneButton.setTitle("Player One", for: .normal)
        addSubview(playerOneButton)
        
        playerTwoButton = UIButton(type: .system)
        playerTwoButton.addTarget(self, action: #selector(playerTwoButtonPressed(sender:)), for: .touchUpInside)
        playerTwoButton.layer.borderColor = UIColor.border.cgColor
        playerTwoButton.layer.borderWidth = 1
        playerTwoButton.setTitle("Player Two", for: .normal)
        addSubview(playerTwoButton)
        
        couldntReachButton = UIButton(type: .system)
        couldntReachButton.addTarget(self, action: #selector(couldntReachButtonPressed(sender:)), for: .touchUpInside)
        couldntReachButton.isEnabled = false
        couldntReachButton.layer.borderColor = UIColor.border.cgColor
        couldntReachButton.layer.borderWidth = 1
        couldntReachButton.setTitle("Couldn't Reach", for: .normal)
        addSubview(couldntReachButton)
        
        hitNetButton = UIButton(type: .system)
        hitNetButton.addTarget(self, action: #selector(hitNetButtonPressed(sender:)), for: .touchUpInside)
        hitNetButton.isEnabled = false
        hitNetButton.layer.borderColor = UIColor.border.cgColor
        hitNetButton.layer.borderWidth = 1
        hitNetButton.setTitle("Hit Net", for: .normal)
        addSubview(hitNetButton)
        
        hitOutButton = UIButton(type: .system)
        hitOutButton.addTarget(self, action: #selector(hitOutButtonPressed(sender:)), for: .touchUpInside)
        hitOutButton.isEnabled = false
        hitOutButton.layer.borderColor = UIColor.border.cgColor
        hitOutButton.layer.borderWidth = 1
        hitOutButton.setTitle("Hit Out", for: .normal)
        addSubview(hitOutButton)
        
        leftInButton = UIButton(type: .system)
        leftInButton.addTarget(self, action: #selector(leftInButtonPressed(sender:)), for: .touchUpInside)
        leftInButton.isEnabled = false
        leftInButton.layer.borderColor = UIColor.border.cgColor
        leftInButton.layer.borderWidth = 1
        leftInButton.setTitle("Left In", for: .normal)
        addSubview(leftInButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = bounds.width / 2
        let h = bounds.height / 3
        
        playerOneButton.frame = CGRect(x: 0, y: 0, width: w, height: h)
        playerTwoButton.frame = CGRect(x: w, y: 0, width: w, height: h)
        couldntReachButton.frame = CGRect(x: 0, y: h, width: w, height: h)
        hitNetButton.frame = CGRect(x: w, y: h, width: w, height: h)
        hitOutButton.frame = CGRect(x: 0, y: 2 * h, width: w, height: h)
        leftInButton.frame = CGRect(x: w, y: 2 * h, width: w, height: h)
    }
    
    func load(point: Point) {
        playerOneButton.backgroundColor = point.winner == playerOne ? .highlighted : .white
        playerTwoButton.backgroundColor = point.winner == playerTwo ? .highlighted : .white
        couldntReachButton.backgroundColor = point.result == PointResult.couldntReach ? .highlighted : .white
        hitNetButton.backgroundColor = point.result == PointResult.hitNet ? .highlighted : .white
        hitOutButton.backgroundColor = point.result == PointResult.hitOut ? .highlighted : .white
        leftInButton.backgroundColor = point.result == PointResult.leftIn ? .highlighted : .white
    }
    
    func resetButtons() {
        playerOneButton.backgroundColor = .white
        playerTwoButton.backgroundColor = .white
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
        
        couldntReachButton.isEnabled = true
        hitNetButton.isEnabled = true
        hitOutButton.isEnabled = true
        leftInButton.isEnabled = true
    }
    
    @objc private func playerOneButtonPressed(sender: UIButton) {
        resetButtons()
        
        playerOneButton.backgroundColor = .highlighted
        
        winner = playerOne
        delegate?.resultSelector(self, selectedWinner: playerOne, withResult: .unknown)
    }
    
    @objc private func playerTwoButtonPressed(sender: UIButton) {
        resetButtons()
        
        playerTwoButton.backgroundColor = .highlighted
        
        winner = playerTwo
        delegate?.resultSelector(self, selectedWinner: playerTwo, withResult: .unknown)
    }
    
    @objc private func couldntReachButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .highlighted
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
        
        if let winner = winner {
            delegate?.resultSelector(self, selectedWinner: winner, withResult: .couldntReach)
        }
    }
    
    @objc private func hitNetButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .highlighted
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
        
        if let winner = winner {
            delegate?.resultSelector(self, selectedWinner: winner, withResult: .hitNet)
        }
    }
    
    @objc private func hitOutButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .highlighted
        leftInButton.backgroundColor = .white
        
        if let winner = winner {
            delegate?.resultSelector(self, selectedWinner: winner, withResult: .hitOut)
        }
    }
    
    @objc private func leftInButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .highlighted
        
        if let winner = winner {
            delegate?.resultSelector(self, selectedWinner: winner, withResult: .leftIn)
        }
    }
}

protocol ResultSelectorViewDelegate {
    func resultSelector(_ selectorView: ResultSelectorView, selectedWinner winner: Player, withResult result: PointResult)
}
