//
//  CourtShotView.swift
//  Scoresheet
//
//  Created by Jack Cook on 11/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class CourtShotView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
        
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
    }
}
