//
//  ResultSelectorView.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ResultSelectorView: UIView {
    
    var delegate: ResultSelectorViewDelegate?
    
    private var couldntReachButton: UIButton!
    private var hitNetButton: UIButton!
    private var hitOutButton: UIButton!
    private var leftInButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 2
        
        couldntReachButton = UIButton(type: .system)
        couldntReachButton.addTarget(self, action: #selector(couldntReachButtonPressed(sender:)), for: .touchUpInside)
        couldntReachButton.layer.borderColor = UIColor.border.cgColor
        couldntReachButton.layer.borderWidth = 1
        couldntReachButton.setTitle("Couldn't Reach", for: .normal)
        addSubview(couldntReachButton)
        
        hitNetButton = UIButton(type: .system)
        hitNetButton.addTarget(self, action: #selector(hitNetButtonPressed(sender:)), for: .touchUpInside)
        hitNetButton.layer.borderColor = UIColor.border.cgColor
        hitNetButton.layer.borderWidth = 1
        hitNetButton.setTitle("Hit Net", for: .normal)
        addSubview(hitNetButton)
        
        hitOutButton = UIButton(type: .system)
        hitOutButton.addTarget(self, action: #selector(hitOutButtonPressed(sender:)), for: .touchUpInside)
        hitOutButton.layer.borderColor = UIColor.border.cgColor
        hitOutButton.layer.borderWidth = 1
        hitOutButton.setTitle("Hit Out", for: .normal)
        addSubview(hitOutButton)
        
        leftInButton = UIButton(type: .system)
        leftInButton.addTarget(self, action: #selector(leftInButtonPressed(sender:)), for: .touchUpInside)
        leftInButton.layer.borderColor = UIColor.border.cgColor
        leftInButton.layer.borderWidth = 1
        leftInButton.setTitle("Left In", for: .normal)
        addSubview(leftInButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = bounds.width / 2
        let h = bounds.height / 2
        
        couldntReachButton.frame = CGRect(x: 0, y: 0, width: w, height: h)
        hitNetButton.frame = CGRect(x: w, y: 0, width: w, height: h)
        hitOutButton.frame = CGRect(x: 0, y: h, width: w, height: h)
        leftInButton.frame = CGRect(x: w, y: h, width: w, height: h)
    }
    
    func update(_ point: Point) {
        couldntReachButton.backgroundColor = point.result == PointResult.couldntReach ? .highlighted : .white
        hitNetButton.backgroundColor = point.result == PointResult.hitNet ? .highlighted : .white
        hitOutButton.backgroundColor = point.result == PointResult.hitOut ? .highlighted : .white
        leftInButton.backgroundColor = point.result == PointResult.leftIn ? .highlighted : .white
    }
    
    func resetButtons() {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
    }
    
    @objc private func couldntReachButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .highlighted
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
        
        delegate?.resultSelector(self, selectedResult: .couldntReach)
    }
    
    @objc private func hitNetButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .highlighted
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .white
        
        delegate?.resultSelector(self, selectedResult: .hitNet)
    }
    
    @objc private func hitOutButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .highlighted
        leftInButton.backgroundColor = .white
        
        delegate?.resultSelector(self, selectedResult: .hitOut)
    }
    
    @objc private func leftInButtonPressed(sender: UIButton) {
        couldntReachButton.backgroundColor = .white
        hitNetButton.backgroundColor = .white
        hitOutButton.backgroundColor = .white
        leftInButton.backgroundColor = .highlighted
        
        delegate?.resultSelector(self, selectedResult: .leftIn)
    }
}

protocol ResultSelectorViewDelegate {
    func resultSelector(_ selectorView: ResultSelectorView, selectedResult result: PointResult)
}
