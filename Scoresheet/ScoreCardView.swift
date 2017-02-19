//
//  ScoreCardView.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ScoreCardView: UIScrollView, PointViewDelegate, UITextFieldDelegate {
    
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
                
                if point.winner == .first {
                    pointView.pointViewState = .topWinner
                } else if point.winner == .second {
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
        firstNameTextField.text = "Player One"
        addSubview(firstNameTextField)
        
        secondNameTextField = UITextField()
        secondNameTextField.delegate = self
        secondNameTextField.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        secondNameTextField.returnKeyType = .done
        secondNameTextField.text = "Player Two"
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
    
    func update(_ game: Game) {
        firstNameTextField.text = game.playerOne.name
        secondNameTextField.text = game.playerTwo.name
        points = game.points
    }
    
    func updatePoint(point: Point) {
        points[selectedIndex] = point
        
        if selectedIndex == pointViews.count - 1 {
            var newPoint = Point()
            newPoint.server = point.winner == .first ? .first : .second
            points.append(newPoint)
        }
    }
    
    func selected(pointView: PointView) {
        selectedIndex = pointView.tag
        
        for pv in pointViews where pv != pointView {
            pv.backgroundColor = .white
        }
        
        pointView.backgroundColor = UIColor.highlighted
        
        scoreCardDelegate?.selectedPoint(scoreCard: self, point: pointView.tag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return textField.text?.characters.count ?? 1 > 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == firstNameTextField {
            scoreCardDelegate?.updatedName(playerId: 1, name: textField.text ?? "Player One")
        } else if textField == secondNameTextField {
            scoreCardDelegate?.updatedName(playerId: 2, name: textField.text ?? "Player Two")
        }
        
        setNeedsLayout()
        
        UIView.animate(withDuration: 0.25) { 
            self.layoutIfNeeded()
        }
    }
}

protocol ScoreCardViewDelegate {
    func selectedPoint(scoreCard: ScoreCardView, point: Int)
    func updatedName(playerId: Int, name: String)
}
