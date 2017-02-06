//
//  PointView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class PointView: UIButton {
    
    var delegate: PointViewDelegate?
    
    private var leftBorder: CALayer!
    private var markerLabel: UILabel!
    
    var winner: Int = 0 {
        didSet {
            switch winner {
            case 0:
                markerLabel.isHidden = true
            case 1, 2:
                markerLabel.isHidden = false
            default: break
            }
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
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
            markerLabel.isHidden = true
            markerLabel.text = "X"
            markerLabel.textColor = UIColor(white: 0.5, alpha: 1)
            addSubview(markerLabel)
        }
        markerLabel.sizeToFit()
        
        var markerY: CGFloat = 0
        
        if winner == 1 {
            markerY = (((bounds.height / 2) - 1) - markerLabel.bounds.height) / 2
        } else if winner == 2 {
            markerY = (((bounds.height / 2) - 1) - markerLabel.bounds.height) / 2 + bounds.height / 2
        }
        
        markerLabel.frame = CGRect(x: 2 + ((bounds.width - 2) - markerLabel.bounds.width) / 2, y: markerY, width: markerLabel.bounds.width, height: markerLabel.bounds.height)
    }
    
    func tapped() {
        delegate?.selected(pointView: self)
    }
}

protocol PointViewDelegate {
    func selected(pointView: PointView)
}
