//
//  NetView.swift
//  Scoresheet
//
//  Created by Jack Cook on 11/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class NetView: UIView {
    
    private var dots: [UIView]!
    
    init() {
        super.init(frame: CGRect.zero)
        
        dots = [UIView]()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let neededDots = (Int(bounds.width) - 1) / 6 + 1
        
        if neededDots < dots.count {
            dots.removeLast(dots.count - neededDots)
        } else if neededDots > dots.count {
            for _ in 0..<neededDots - dots.count {
                let dot = UIView()
                dot.backgroundColor = .white
                dot.layer.cornerRadius = 2
                addSubview(dot)
                dots.append(dot)
            }
        }
        
        for (idx, dot) in dots.enumerated() {
            dot.frame = CGRect(x: 1 + idx * 6, y: 0, width: 4, height: 4)
        }
    }
}
