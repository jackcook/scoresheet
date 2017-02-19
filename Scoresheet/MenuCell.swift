//
//  MenuCell.swift
//  Scoresheet
//
//  Created by Jack Cook on 2/18/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    private var maskCorners = UIRectCorner(rawValue: 0)
    private var maskLayer: CAShapeLayer?
    private var otherMaskLayer: CAShapeLayer?
    
    private var shadow = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        
        if !maskCorners.isEmpty {
            let maskPath = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: maskCorners, cornerRadii: CGSize(width: 4, height: 4))
            
            maskLayer = CAShapeLayer()
            maskLayer?.frame = containerView.bounds
            maskLayer?.path = maskPath.cgPath
            innerView.layer.mask = maskLayer
        }
        
        let shadowPath = UIBezierPath(rect: containerView.bounds)
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowPath = shadowPath.cgPath
        
        if maskCorners.isEmpty || (maskCorners.contains(.topLeft) && !maskCorners.contains(.bottomLeft)) {
            let shadowMaskPath = UIBezierPath(rect: CGRect(x: -4, y: -4, width: containerView.bounds.width + 8, height: containerView.bounds.height + 4))
            otherMaskLayer = CAShapeLayer()
            otherMaskLayer?.frame = containerView.bounds
            otherMaskLayer?.path = shadowMaskPath.cgPath
            containerView.layer.mask = otherMaskLayer
        }
        
        if maskCorners.contains(.bottomLeft) {
            separatorView.alpha = 0
        }
    }
    
    func configure(_ game: Game) {
        playerOneLabel.text = game.playerOne.name
        playerTwoLabel.text = game.playerTwo.name
        
        var playerOneScore = 0
        var playerTwoScore = 0
        
        for point in game.points {
            if point.winnerId == 1 {
                playerOneScore += 1
            } else if point.winnerId == 2 {
                playerTwoScore += 1
            }
        }
        
        playerOneScoreLabel.text = "\(playerOneScore)"
        playerTwoScoreLabel.text = "\(playerTwoScore)"
        
        if playerOneScore > playerTwoScore {
            playerOneLabel.font = UIFont.boldSystemFont(ofSize: 17)
            playerOneScoreLabel.font = UIFont.boldSystemFont(ofSize: 17)
        } else if playerTwoScore > playerOneScore {
            playerTwoLabel.font = UIFont.boldSystemFont(ofSize: 17)
            playerTwoScoreLabel.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    
    func roundCorners(_ side: Side) {
        switch side {
        case .top:
            maskCorners = [.topLeft, .topRight]
        case .bottom:
            maskCorners = [.bottomLeft, .bottomRight]
        case .both:
            maskCorners = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        innerView.backgroundColor = highlighted ? UIColor(red: 1, green: 235/255, blue: 238/255, alpha: 1) : .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        innerView.backgroundColor = selected ? UIColor(red: 1, green: 235/255, blue: 238/255, alpha: 1) : .white
    }
}

enum Side {
    case top, bottom, both
}
