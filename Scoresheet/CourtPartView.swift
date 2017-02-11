//
//  CourtPartView.swift
//  Scoresheet
//
//  Created by Jack Cook on 11/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class CourtPartView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(red: 46/255, green: 151/255, blue: 38/255, alpha: 1)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
