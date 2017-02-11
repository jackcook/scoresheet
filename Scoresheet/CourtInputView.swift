//
//  CourtInputView.swift
//  Scoresheet
//
//  Created by Jack Cook on 11/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class CourtInputView: UIView {
    
    private var backLeft1: UIView!
    private var backMiddleLeft1: UIView!
    private var backMiddleRight1: UIView!
    private var backRight1: UIView!
    private var middleLeft1: UIView!
    private var middleMiddleLeft1: UIView!
    private var middleMiddleRight1: UIView!
    private var middleRight1: UIView!
    private var centerLeft: UIView!
    private var centerMiddle: UIView!
    private var centerRight: UIView!
    private var middleLeft2: UIView!
    private var middleMiddleLeft2: UIView!
    private var middleMiddleRight2: UIView!
    private var middleRight2: UIView!
    private var backLeft2: UIView!
    private var backMiddleLeft2: UIView!
    private var backMiddleRight2: UIView!
    private var backRight2: UIView!
    
    private var netView: NetView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let court = CGSize(width: bounds.width - 2, height: bounds.height - 2)
        
        let side = (460 / 6060) * court.width
        let middle = (2570 / 6060) * court.width
        let centerCenter = (5140 / 6060) * court.width
        
        let top = (760 / 13360) * court.height
        let bottom = (3920 / 13360) * court.height
        let center = (4000 / 13360) * court.height
        
        let green = UIColor(red: 46/255, green: 151/255, blue: 38/255, alpha: 1)
        let white = UIColor.white.cgColor
        
        layer.borderColor = white
        layer.borderWidth = 1
        
        if backLeft1 == nil {
            backLeft1 = UIView()
            backLeft1.backgroundColor = green
            backLeft1.layer.borderColor = white
            backLeft1.layer.borderWidth = 1
            addSubview(backLeft1)
        }
        backLeft1.frame = CGRect(x: 1, y: 1, width: side, height: top)
        
        if backMiddleLeft1 == nil {
            backMiddleLeft1 = UIView()
            backMiddleLeft1.backgroundColor = green
            backMiddleLeft1.layer.borderColor = white
            backMiddleLeft1.layer.borderWidth = 1
            addSubview(backMiddleLeft1)
        }
        backMiddleLeft1.frame = CGRect(x: backLeft1.frame.origin.x + backLeft1.frame.size.width, y: 1, width: middle, height: top)
        
        if backMiddleRight1 == nil {
            backMiddleRight1 = UIView()
            backMiddleRight1.backgroundColor = green
            backMiddleRight1.layer.borderColor = white
            backMiddleRight1.layer.borderWidth = 1
            addSubview(backMiddleRight1)
        }
        backMiddleRight1.frame = CGRect(x: backMiddleLeft1.frame.origin.x + backMiddleLeft1.frame.size.width, y: 1, width: middle, height: top)
        
        if backRight1 == nil {
            backRight1 = UIView()
            backRight1.backgroundColor = green
            backRight1.layer.borderColor = white
            backRight1.layer.borderWidth = 1
            addSubview(backRight1)
        }
        backRight1.frame = CGRect(x: backMiddleRight1.frame.origin.x + backMiddleRight1.frame.size.width, y: 1, width: side, height: top)
        
        if middleLeft1 == nil {
            middleLeft1 = UIView()
            middleLeft1.backgroundColor = green
            middleLeft1.layer.borderColor = white
            middleLeft1.layer.borderWidth = 1
            addSubview(middleLeft1)
        }
        middleLeft1.frame = CGRect(x: 1, y: backLeft1.frame.origin.y + backLeft1.frame.size.height, width: side, height: bottom)
        
        if middleMiddleLeft1 == nil {
            middleMiddleLeft1 = UIView()
            middleMiddleLeft1.backgroundColor = green
            middleMiddleLeft1.layer.borderColor = white
            middleMiddleLeft1.layer.borderWidth = 1
            addSubview(middleMiddleLeft1)
        }
        middleMiddleLeft1.frame = CGRect(x: middleLeft1.frame.origin.x + middleLeft1.frame.size.width, y: backMiddleLeft1.frame.origin.y + backMiddleLeft1.frame.size.height, width: middle, height: bottom)
        
        if middleMiddleRight1 == nil {
            middleMiddleRight1 = UIView()
            middleMiddleRight1.backgroundColor = green
            middleMiddleRight1.layer.borderColor = white
            middleMiddleRight1.layer.borderWidth = 1
            addSubview(middleMiddleRight1)
        }
        middleMiddleRight1.frame = CGRect(x: middleMiddleLeft1.frame.origin.x + middleMiddleLeft1.frame.size.width, y: backMiddleRight1.frame.origin.y + backMiddleRight1.frame.size.height, width: middle, height: bottom)
        
        if middleRight1 == nil {
            middleRight1 = UIView()
            middleRight1.backgroundColor = green
            middleRight1.layer.borderColor = white
            middleRight1.layer.borderWidth = 1
            addSubview(middleRight1)
        }
        middleRight1.frame = CGRect(x: middleMiddleRight1.frame.origin.x + middleMiddleRight1.frame.size.width, y: backRight1.frame.origin.y + backRight1.frame.size.height, width: side, height: bottom)
        
        if centerLeft == nil {
            centerLeft = UIView()
            centerLeft.backgroundColor = green
            centerLeft.layer.borderColor = white
            centerLeft.layer.borderWidth = 1
            addSubview(centerLeft)
        }
        centerLeft.frame = CGRect(x: 1, y: middleLeft1.frame.origin.y + middleLeft1.frame.size.height, width: side, height: center)
        
        if centerMiddle == nil {
            centerMiddle = UIView()
            centerMiddle.backgroundColor = green
            centerMiddle.layer.borderColor = white
            centerMiddle.layer.borderWidth = 1
            addSubview(centerMiddle)
        }
        centerMiddle.frame = CGRect(x: centerLeft.frame.origin.x + centerLeft.frame.size.width, y: middleMiddleLeft1.frame.origin.y + middleMiddleLeft1.frame.size.height, width: centerCenter, height: center)
        
        if centerRight == nil {
            centerRight = UIView()
            centerRight.backgroundColor = green
            centerRight.layer.borderColor = white
            centerRight.layer.borderWidth = 1
            addSubview(centerRight)
        }
        centerRight.frame = CGRect(x: centerMiddle.frame.origin.x + centerMiddle.frame.size.width, y: middleRight1.frame.origin.y + middleRight1.frame.size.height, width: side, height: center)
        
        if middleLeft2 == nil {
            middleLeft2 = UIView()
            middleLeft2.backgroundColor = green
            middleLeft2.layer.borderColor = white
            middleLeft2.layer.borderWidth = 1
            addSubview(middleLeft2)
        }
        middleLeft2.frame = CGRect(x: 1, y: centerLeft.frame.origin.y + centerLeft.frame.size.height, width: side, height: bottom)
        
        if middleMiddleLeft2 == nil {
            middleMiddleLeft2 = UIView()
            middleMiddleLeft2.backgroundColor = green
            middleMiddleLeft2.layer.borderColor = white
            middleMiddleLeft2.layer.borderWidth = 1
            addSubview(middleMiddleLeft2)
        }
        middleMiddleLeft2.frame = CGRect(x: middleLeft2.frame.origin.x + middleLeft2.frame.size.width, y: centerMiddle.frame.origin.y + centerMiddle.frame.size.height, width: middle, height: bottom)
        
        if middleMiddleRight2 == nil {
            middleMiddleRight2 = UIView()
            middleMiddleRight2.backgroundColor = green
            middleMiddleRight2.layer.borderColor = white
            middleMiddleRight2.layer.borderWidth = 1
            addSubview(middleMiddleRight2)
        }
        middleMiddleRight2.frame = CGRect(x: middleMiddleLeft2.frame.origin.x + middleMiddleLeft2.frame.size.width, y: centerMiddle.frame.origin.y + centerMiddle.frame.size.height, width: middle, height: bottom)
        
        if middleRight2 == nil {
            middleRight2 = UIView()
            middleRight2.backgroundColor = green
            middleRight2.layer.borderColor = white
            middleRight2.layer.borderWidth = 1
            addSubview(middleRight2)
        }
        middleRight2.frame = CGRect(x: middleMiddleRight2.frame.origin.x + middleMiddleRight2.frame.size.width, y: centerRight.frame.origin.y + centerRight.frame.size.height, width: side, height: bottom)
        
        if backLeft2 == nil {
            backLeft2 = UIView()
            backLeft2.backgroundColor = green
            backLeft2.layer.borderColor = white
            backLeft2.layer.borderWidth = 1
            addSubview(backLeft2)
        }
        backLeft2.frame = CGRect(x: 1, y: middleRight2.frame.origin.y + middleRight2.frame.size.height, width: side, height: top)
        
        if backMiddleLeft2 == nil {
            backMiddleLeft2 = UIView()
            backMiddleLeft2.backgroundColor = green
            backMiddleLeft2.layer.borderColor = white
            backMiddleLeft2.layer.borderWidth = 1
            addSubview(backMiddleLeft2)
        }
        backMiddleLeft2.frame = CGRect(x: backLeft2.frame.origin.x + backLeft2.frame.size.width, y: middleMiddleLeft2.frame.origin.y + middleMiddleLeft2.frame.size.height, width: middle, height: top)
        
        if backMiddleRight2 == nil {
            backMiddleRight2 = UIView()
            backMiddleRight2.backgroundColor = green
            backMiddleRight2.layer.borderColor = white
            backMiddleRight2.layer.borderWidth = 1
            addSubview(backMiddleRight2)
        }
        backMiddleRight2.frame = CGRect(x: backMiddleLeft2.frame.origin.x + backMiddleLeft2.frame.size.width, y: middleMiddleRight2.frame.origin.y + middleMiddleRight2.frame.size.height, width: middle, height: top)
        
        if backRight2 == nil {
            backRight2 = UIView()
            backRight2.backgroundColor = green
            backRight2.layer.borderColor = white
            backRight2.layer.borderWidth = 1
            addSubview(backRight2)
        }
        backRight2.frame = CGRect(x: backMiddleRight2.frame.origin.x + backMiddleRight2.frame.size.width, y: middleRight2.frame.origin.y + middleRight2.frame.size.height, width: side, height: top)
        
        if netView == nil {
            netView = NetView()
            addSubview(netView)
        }
        netView.frame = CGRect(x: 3, y: (bounds.height - 4) / 2, width: court.width, height: 4)
    }
}
