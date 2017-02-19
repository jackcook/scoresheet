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
    
    var pointViewState = PointViewState.noWinner {
        didSet {
            if let _ = markerLabel {
                markerLabel.isHidden = pointViewState == .noWinner
                
                setNeedsLayout()
                layoutIfNeeded()
            }
        }
    }
    
    private var leftBorder: CALayer!
    private var markerLabel: UILabel!
    
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
            leftBorder.backgroundColor = UIColor.border.cgColor
            layer.addSublayer(leftBorder)
        }
        leftBorder.frame = CGRect(x: 0, y: 0, width: 2, height: bounds.height)
        
        if markerLabel == nil {
            markerLabel = UILabel()
            markerLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
            markerLabel.isHidden = pointViewState == .noWinner
            markerLabel.text = "X"
            markerLabel.textColor = UIColor(white: 0.5, alpha: 1)
            addSubview(markerLabel)
        }
        markerLabel.sizeToFit()
        
        var markerY: CGFloat = 0
        
        if pointViewState == .topWinner {
            markerY = (((bounds.height / 2) - 1) - markerLabel.bounds.height) / 2
        } else if pointViewState == .bottomWinner {
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

enum PointViewState {
    case noWinner
    case topWinner
    case bottomWinner
}
