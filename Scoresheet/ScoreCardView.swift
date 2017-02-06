//
//  ScoreCardView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ScoreCardView: UIScrollView, PointViewDelegate {
    
    var game: Game! {
        didSet {
            firstNameLabel.text = game.playerOne.name
            secondNameLabel.text = game.playerTwo.name
        }
    }
    
    var scoreCardDelegate: ScoreCardViewDelegate?
    var selectedIndex = 0
    
    private var firstNameLabel: UILabel!
    private var secondNameLabel: UILabel!
    private var pointViews: [PointView]!
    private var middleBorder: CALayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 2
        
        firstNameLabel = UILabel()
        firstNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        firstNameLabel.text = "Player 1"
        addSubview(firstNameLabel)
        
        secondNameLabel = UILabel()
        secondNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        secondNameLabel.text = "Player 2"
        addSubview(secondNameLabel)
        
        pointViews = [PointView]()
        
        let firstPointView = PointView()
        firstPointView.delegate = self
        firstPointView.tag = 0
        firstPointView.tapped()
        
        addSubview(firstPointView)
        pointViews.append(firstPointView)
        
        middleBorder = CALayer()
        middleBorder.backgroundColor = UIColor.border.cgColor
        layer.addSublayer(middleBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstNameLabel.sizeToFit()
        firstNameLabel.frame = CGRect(x: 16, y: ((bounds.height / 2) - firstNameLabel.bounds.height) / 2, width: firstNameLabel.bounds.width, height: firstNameLabel.bounds.height)
        
        secondNameLabel.sizeToFit()
        secondNameLabel.frame = CGRect(x: 16, y: ((bounds.height / 2) - secondNameLabel.bounds.height) / 2 + bounds.height / 2, width: secondNameLabel.bounds.width, height: secondNameLabel.bounds.height)
        
        let startingX = max(firstNameLabel.bounds.width, secondNameLabel.bounds.width) + 32
        
        for (idx, pointView) in pointViews.enumerated() {
            pointView.frame = CGRect(x: startingX + CGFloat(idx) * 44, y: 0, width: 44, height: bounds.height)
            
            if idx == pointViews.count - 1 {
                contentSize = CGSize(width: pointView.frame.origin.x + pointView.frame.size.width, height: pointView.frame.size.height)
            }
        }
        
        middleBorder.frame = CGRect(x: -1024, y: (bounds.height - 2) / 2, width: bounds.width + 2048, height: 2)
    }
    
    func updatePoint(point: Point) {
        if point.winner == game.playerOne {
            pointViews[selectedIndex].pointViewState = .topWinner
        } else if point.winner == game.playerTwo {
            pointViews[selectedIndex].pointViewState = .bottomWinner
        } else {
            pointViews[selectedIndex].pointViewState = .noWinner
        }
        
        if selectedIndex == pointViews.count - 1 {
            let nextPointView = PointView()
            nextPointView.delegate = self
            nextPointView.tag = pointViews.count
            
            insertSubview(nextPointView, at: 0)
            pointViews.append(nextPointView)
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    func selected(pointView: PointView) {
        selectedIndex = pointView.tag
        
        for pv in pointViews where pv != pointView {
            pv.backgroundColor = .white
        }
        
        pointView.backgroundColor = UIColor.highlighted
        
        scoreCardDelegate?.selected(scoreCard: self, shot: pointView.tag)
    }
}

protocol ScoreCardViewDelegate {
    func selected(scoreCard: ScoreCardView, shot: Int)
}
