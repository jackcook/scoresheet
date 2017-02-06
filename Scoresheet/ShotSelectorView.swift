//
//  ShotSelectorView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ShotSelectorView: UIView {
    
    var delegate: ShotSelectorViewDelegate?
    
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
        
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 2
        
        shortServeButton = UIButton(type: .system)
        shortServeButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        shortServeButton.layer.borderColor = UIColor.border.cgColor
        shortServeButton.layer.borderWidth = 1
        shortServeButton.setTitle("Short Serve", for: .normal)
        addSubview(shortServeButton)
        
        longServeButton = UIButton(type: .system)
        longServeButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        longServeButton.layer.borderColor = UIColor.border.cgColor
        longServeButton.layer.borderWidth = 1
        longServeButton.setTitle("Long Serve", for: .normal)
        addSubview(longServeButton)
        
        driveButton = UIButton(type: .system)
        driveButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        driveButton.layer.borderColor = UIColor.border.cgColor
        driveButton.layer.borderWidth = 1
        driveButton.setTitle("Drive", for: .normal)
        addSubview(driveButton)
        
        clearButton = UIButton(type: .system)
        clearButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        clearButton.layer.borderColor = UIColor.border.cgColor
        clearButton.layer.borderWidth = 1
        clearButton.setTitle("Clear", for: .normal)
        addSubview(clearButton)
        
        netButton = UIButton(type: .system)
        netButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        netButton.layer.borderColor = UIColor.border.cgColor
        netButton.layer.borderWidth = 1
        netButton.setTitle("Net", for: .normal)
        addSubview(netButton)
        
        dropButton = UIButton(type: .system)
        dropButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        dropButton.layer.borderColor = UIColor.border.cgColor
        dropButton.layer.borderWidth = 1
        dropButton.setTitle("Drop", for: .normal)
        addSubview(dropButton)
        
        smashButton = UIButton(type: .system)
        smashButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        smashButton.layer.borderColor = UIColor.border.cgColor
        smashButton.layer.borderWidth = 1
        smashButton.setTitle("Smash", for: .normal)
        addSubview(smashButton)
        
        crossNetButton = UIButton(type: .system)
        crossNetButton.addTarget(self, action: #selector(shotButtonPressed(sender:)), for: .touchUpInside)
        crossNetButton.layer.borderColor = UIColor.border.cgColor
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
    
    @objc private func shotButtonPressed(sender: UIButton) {
        var shot = "?"
        
        if sender == shortServeButton {
            shot = "SS"
        } else if sender == longServeButton {
            shot = "LS"
        } else if sender == driveButton {
            shot = "D"
        } else if sender == clearButton {
            shot = "C"
        } else if sender == netButton {
            shot = "N"
        } else if sender == dropButton {
            shot = "DR"
        } else if sender == smashButton {
            shot = "S"
        } else if sender == crossNetButton {
            shot = "CN"
        }
        
        delegate?.shotSelector(selector: self, shotSelected: shot)
    }
}

protocol ShotSelectorViewDelegate {
    func shotSelector(selector: ShotSelectorView, shotSelected shot: String)
}
