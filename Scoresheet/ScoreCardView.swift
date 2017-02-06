//
//  ScoreCardView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ScoreCardView: UIScrollView, PointViewDelegate {
    
    var scoreCardDelegate: ScoreCardViewDelegate?
    
    private var firstNameLabel: UILabel!
    private var secondNameLabel: UILabel!
    private var pointViews: [PointView]!
    private var middleBorder: CALayer!
    
    private var selectedIndex = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        layer.borderWidth = 2
        
        firstNameLabel = UILabel()
        firstNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        firstNameLabel.text = "Angela Chou"
        addSubview(firstNameLabel)
        
        secondNameLabel = UILabel()
        secondNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        secondNameLabel.text = "Tai Tzu-ying"
        addSubview(secondNameLabel)
        
        pointViews = [PointView]()
        
        let firstPointView = PointView()
        firstPointView.delegate = self
        firstPointView.tag = 0
        firstPointView.tapped()
        
        addSubview(firstPointView)
        pointViews.append(firstPointView)
        
        middleBorder = CALayer()
        middleBorder.backgroundColor = UIColor(white: 0.75, alpha: 1).cgColor
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
    
    func selectPointWinner(playerOne: Bool) {
        pointViews[selectedIndex].winner = playerOne ? 1 : 2
        
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
        
        pointView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        scoreCardDelegate?.selected(scoreCard: self, shot: pointView.tag)
    }
}

protocol ScoreCardViewDelegate {
    func selected(scoreCard: ScoreCardView, shot: Int)
}
