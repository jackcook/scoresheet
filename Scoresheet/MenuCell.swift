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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    
    private var game: Game!
    
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
        
        moreButton.setImage(moreButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        moreButton.tintColor = UIColor(white: 0.25, alpha: 1)
    }
    
    func configure(_ game: Game) {
        self.game = game
        
        playerOneLabel.text = game.playerOne.name
        playerTwoLabel.text = game.playerTwo.name
        
        var playerOneScore = 0
        var playerTwoScore = 0
        
        for point in game.points {
            if point.winner == .first {
                playerOneScore += 1
            } else if point.winner == .second {
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
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        dateLabel.text = formatter.string(from: game.creationDate)
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
    
    @IBAction func moreButtonPressed(sender: UIButton) {
        let controller = UIAlertController(title: nil, message: "What would you like to do with this game?", preferredStyle: .actionSheet)
        
        controller.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        controller.popoverPresentationController?.sourceRect = moreButton.frame
        controller.popoverPresentationController?.sourceView = self
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let filePath = "\(documentsDirectory)/\(self.game.id).game"
            
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch {
                print("error deleting file")
            }
            
            (self.viewController as? MenuViewController)?.reloadGames()
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default) { action in
            do {
                let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let gameData = try NSData(contentsOfFile: "\(documentsDirectory)/\(self.game.id).game") as Data
                
                let activityController = UIActivityViewController(activityItems: ["Test", gameData], applicationActivities: nil)
                activityController.modalPresentationStyle = .popover
                
                self.viewController?.present(activityController, animated: true, completion: nil)
                
                let popoverController = activityController.popoverPresentationController
                popoverController?.permittedArrowDirections = [.up, .down]
                popoverController?.sourceRect = self.moreButton.frame
                popoverController?.sourceView = self
            } catch {
                print("error sharing file")
            }
        }
        
        controller.addAction(deleteAction)
        controller.addAction(shareAction)
        
        viewController?.present(controller, animated: true, completion: nil)
    }
}

enum Side {
    case top, bottom, both
}
