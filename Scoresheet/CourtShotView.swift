//
//  CourtShotView.swift
//  Scoresheet
//
//  Created by Jack Cook on 11/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class CourtShotView: UIView {
    
    var number = 0
    
    private var numberLabel: UILabel!
    
    override var tag: Int {
        didSet {
            numberLabel.text = "\(tag + 1)"
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .white
        
        numberLabel = UILabel()
        numberLabel.font = UIFont.systemFont(ofSize: 9, weight: UIFontWeightLight)
        numberLabel.textColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
        addSubview(numberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        
        numberLabel.sizeToFit()
        numberLabel.frame = CGRect(x: (bounds.width - numberLabel.frame.size.width) / 2, y: (bounds.height - numberLabel.frame.size.height) / 2, width: numberLabel.frame.size.width, height: numberLabel.frame.size.height)
    }
}
