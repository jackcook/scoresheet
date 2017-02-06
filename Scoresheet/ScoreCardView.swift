//
//  ScoreCardView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ScoreCardView: UIScrollView, PointViewDelegate {
    
    private var firstNameLabel: UILabel!
    private var secondNameLabel: UILabel!
    private var pointViews: [PointView]!
    private var middleBorder: CALayer!
    
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
        
        for i in 0..<21 {
            let pointView = PointView()
            pointView.delegate = self
            pointView.tag = i
            
            addSubview(pointView)
            pointViews.append(pointView)
        }
        
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
    
    func selected(pointView: PointView) {
        for pv in pointViews where pv != pointView {
            pv.backgroundColor = .white
        }
        
        pointView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
}
