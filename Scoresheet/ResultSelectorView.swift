//
//  ResultSelectorView.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ResultSelectorView: UIView {
    
    private var playerOneButton: UIButton!
    private var playerTwoButton: UIButton!
    private var couldntReachButton: UIButton!
    private var hitNetButton: UIButton!
    private var hitOutButton: UIButton!
    private var leftInButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        layer.borderWidth = 2
        
        playerOneButton = UIButton(type: .system)
        playerOneButton.addTarget(self, action: #selector(playerOneButtonPressed(sender:)), for: .touchUpInside)
        playerOneButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        playerOneButton.layer.borderWidth = 1
        playerOneButton.setTitle("Player One", for: .normal)
        addSubview(playerOneButton)
        
        playerTwoButton = UIButton(type: .system)
        playerTwoButton.addTarget(self, action: #selector(playerTwoButtonPressed(sender:)), for: .touchUpInside)
        playerTwoButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        playerTwoButton.layer.borderWidth = 1
        playerTwoButton.setTitle("Player Two", for: .normal)
        addSubview(playerTwoButton)
        
        couldntReachButton = UIButton(type: .system)
        couldntReachButton.addTarget(self, action: #selector(couldntReachButtonPressed(sender:)), for: .touchUpInside)
        couldntReachButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        couldntReachButton.layer.borderWidth = 1
        couldntReachButton.setTitle("Couldn't Reach", for: .normal)
        addSubview(couldntReachButton)
        
        hitNetButton = UIButton(type: .system)
        hitNetButton.addTarget(self, action: #selector(hitNetButtonPressed(sender:)), for: .touchUpInside)
        hitNetButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        hitNetButton.layer.borderWidth = 1
        hitNetButton.setTitle("Hit Net", for: .normal)
        addSubview(hitNetButton)
        
        hitOutButton = UIButton(type: .system)
        hitOutButton.addTarget(self, action: #selector(hitOutButtonPressed(sender:)), for: .touchUpInside)
        hitOutButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        hitOutButton.layer.borderWidth = 1
        hitOutButton.setTitle("Hit Out", for: .normal)
        addSubview(hitOutButton)
        
        leftInButton = UIButton(type: .system)
        leftInButton.addTarget(self, action: #selector(leftInButtonPressed(sender:)), for: .touchUpInside)
        leftInButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
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
    
    @objc private func playerOneButtonPressed(sender: UIButton) {
        playerOneButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        playerTwoButton.backgroundColor = .white
        
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
    }
    
    @objc private func playerTwoButtonPressed(sender: UIButton) {
        playerOneButton.backgroundColor = .white
        playerTwoButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
    }
    
    @objc private func couldntReachButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
    }
    
    @objc private func hitNetButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
    }
    
    @objc private func hitOutButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        leftInButton.backgroundColor = .white
    }
    
    @objc private func leftInButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
}
