//
//  ShotSelectorView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ShotSelectorView: UIView {
    
    private var shortServeButton: UIButton!
    private var longServeButton: UIButton!
    private var driveButton: UIButton!
    private var clearButton: UIButton!
    private var netButton: UIButton!
    private var dropButton: UIButton!
    private var smashButton: UIButton!
    private var crossNetButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        layer.borderWidth = 2
        
        shortServeButton = UIButton(type: .system)
        shortServeButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        shortServeButton.layer.borderWidth = 1
        shortServeButton.setTitle("Short Serve", for: .normal)
        addSubview(shortServeButton)
        
        longServeButton = UIButton(type: .system)
        longServeButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        longServeButton.layer.borderWidth = 1
        longServeButton.setTitle("Long Serve", for: .normal)
        addSubview(longServeButton)
        
        driveButton = UIButton(type: .system)
        driveButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        driveButton.layer.borderWidth = 1
        driveButton.setTitle("Drive", for: .normal)
        addSubview(driveButton)
        
        clearButton = UIButton(type: .system)
        clearButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        clearButton.layer.borderWidth = 1
        clearButton.setTitle("Clear", for: .normal)
        addSubview(clearButton)
        
        netButton = UIButton(type: .system)
        netButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        netButton.layer.borderWidth = 1
        netButton.setTitle("Net", for: .normal)
        addSubview(netButton)
        
        dropButton = UIButton(type: .system)
        dropButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        dropButton.layer.borderWidth = 1
        dropButton.setTitle("Drop", for: .normal)
        addSubview(dropButton)
        
        smashButton = UIButton(type: .system)
        smashButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        smashButton.layer.borderWidth = 1
        smashButton.setTitle("Smash", for: .normal)
        addSubview(smashButton)
        
        crossNetButton = UIButton(type: .system)
        crossNetButton.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        crossNetButton.layer.borderWidth = 1
        crossNetButton.setTitle("Cross Net", for: .normal)
        addSubview(crossNetButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = bounds.width / 3
        let h = bounds.height / 3
        
        shortServeButton.frame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: h)
        longServeButton.frame = CGRect(x: bounds.width / 2, y: 0, width: bounds.width / 2, height: h)
        driveButton.frame = CGRect(x: 0, y: h, width: w, height: h)
        clearButton.frame = CGRect(x: w, y: h, width: w, height: h)
        netButton.frame = CGRect(x: 2 * w, y: h, width: w, height: h)
        dropButton.frame = CGRect(x: 0, y: 2 * h, width: w, height: h)
        smashButton.frame = CGRect(x: w, y: 2 * h, width: w, height: h)
        crossNetButton.frame = CGRect(x: 2 * w, y: 2 * h, width: w, height: h)
    }
}