//
//  PointView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class PointView: UIButton {
    
    private var leftBorder: CALayer!
    private var markerLabel: UILabel!
    
    private var topWinner = Int(arc4random_uniform(2)) == 0
    
    init() {
        super.init(frame: CGRect.zero)
        
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if leftBorder == nil {
            leftBorder = CALayer()
            leftBorder.backgroundColor = UIColor(white: 0.75, alpha: 1).cgColor
            layer.addSublayer(leftBorder)
        }
        leftBorder.frame = CGRect(x: 0, y: 0, width: 2, height: bounds.height)
        
        if markerLabel == nil {
            markerLabel = UILabel()
            markerLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
            markerLabel.text = "X"
            markerLabel.textColor = UIColor(white: 0.5, alpha: 1)
            addSubview(markerLabel)
        }
        markerLabel.sizeToFit()
        markerLabel.frame = CGRect(x: 2 + ((bounds.width - 2) - markerLabel.bounds.width) / 2, y: topWinner ? (((bounds.height / 2) - 1) - markerLabel.bounds.height) / 2 : (((bounds.height / 2) - 1) - markerLabel.bounds.height) / 2 + bounds.height / 2, width: markerLabel.bounds.width, height: markerLabel.bounds.height)
    }
    
    @objc private func tapped() {
        backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
}
