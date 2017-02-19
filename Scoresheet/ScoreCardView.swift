//
//  ScoreCardView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ScoreCardView: UIScrollView, PointViewDelegate, UITextFieldDelegate {
    
    var game: Game! {
        didSet {
            firstNameTextField.text = game.playerOne.name
            secondNameTextField.text = game.playerTwo.name
            points = game.points
            
            pointViews[0].tapped()
        }
    }
    
    var scoreCardDelegate: ScoreCardViewDelegate?
    var selectedIndex = 0
    
    private var points = [Point]() {
        didSet {
            for pointView in pointViews {
                pointView.removeFromSuperview()
            }
            
            pointViews = [PointView]()
            
            for (idx, point) in points.enumerated() {
                let pointView = PointView()
                pointView.delegate = self
                
                if point.winnerId == 1 {
                    pointView.pointViewState = .topWinner
                } else if point.winnerId == 2 {
                    pointView.pointViewState = .bottomWinner
                } else {
                    pointView.pointViewState = .noWinner
                }
                
                pointView.tag = idx
                
                insertSubview(pointView, at: 0)
                pointViews.append(pointView)
            }
            
            pointViews[selectedIndex].tapped()
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private var firstNameTextField: UITextField!
    private var secondNameTextField: UITextField!
    private var pointViews = [PointView]()
    private var middleBorder: CALayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 2
        
        firstNameTextField = UITextField()
        firstNameTextField.delegate = self
        firstNameTextField.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        firstNameTextField.returnKeyType = .done
        firstNameTextField.text = "Player 1"
        addSubview(firstNameTextField)
        
        secondNameTextField = UITextField()
        secondNameTextField.delegate = self
        secondNameTextField.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        secondNameTextField.returnKeyType = .done
        secondNameTextField.text = "Player 2"
        addSubview(secondNameTextField)
        
        middleBorder = CALayer()
        middleBorder.backgroundColor = UIColor.border.cgColor
        layer.addSublayer(middleBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstNameTextField.sizeToFit()
        firstNameTextField.frame = CGRect(x: 16, y: ((bounds.height / 2) - firstNameTextField.bounds.height) / 2, width: firstNameTextField.bounds.width, height: firstNameTextField.bounds.height)
        
        secondNameTextField.sizeToFit()
        secondNameTextField.frame = CGRect(x: 16, y: ((bounds.height / 2) - secondNameTextField.bounds.height) / 2 + bounds.height / 2, width: secondNameTextField.bounds.width, height: secondNameTextField.bounds.height)
        
        let startingX = max(firstNameTextField.bounds.width, secondNameTextField.bounds.width) + 32
        
        for (idx, pointView) in pointViews.enumerated() {
            pointView.frame = CGRect(x: startingX + CGFloat(idx) * 44, y: 0, width: 44, height: bounds.height)
            
            if idx == pointViews.count - 1 {
                contentSize = CGSize(width: pointView.frame.origin.x + pointView.frame.size.width, height: pointView.frame.size.height)
            }
        }
        
        middleBorder.frame = CGRect(x: -1024, y: (bounds.height - 2) / 2, width: bounds.width + 2048, height: 2)
    }
    
    override func resignFirstResponder() -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        
        return true
    }
    
    func updatePoint(point: Point) {
        points[selectedIndex] = point
        
        if selectedIndex == pointViews.count - 1 {
            let newPoint = Point(result: .unknown, serverId: point.winnerId == 1 ? 1 : 2, shots: [Shot](), winnerId: 0)
            points.append(newPoint)
        }
    }
    
    func selected(pointView: PointView) {
        selectedIndex = pointView.tag
        
        for pv in pointViews where pv != pointView {
            pv.backgroundColor = .white
        }
        
        pointView.backgroundColor = UIColor.highlighted
        
        scoreCardDelegate?.selected(scoreCard: self, shot: pointView.tag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return textField.text?.characters.count ?? 1 > 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name = textField.text
        game.points = points
        
        if textField == firstNameTextField {
            game.playerOne = Player(id: 1, name: name ?? "Player One")
            textField.text = game.playerOne.name
        } else if textField == secondNameTextField {
            game.playerTwo = Player(id: 2, name: name ?? "Player Two")
            textField.text = game.playerTwo.name
        }
        
        setNeedsLayout()
        
        UIView.animate(withDuration: 0.25) { 
            self.layoutIfNeeded()
        }
    }
}

protocol ScoreCardViewDelegate {
    func selected(scoreCard: ScoreCardView, shot: Int)
}
