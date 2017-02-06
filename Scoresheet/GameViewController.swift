//
//  GameViewController.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ShotSelectorViewDelegate {
    
    @IBOutlet weak var scoreCard: ScoreCardView!
    @IBOutlet weak var shotSelector: ShotSelectorView!
    @IBOutlet weak var shotsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shotSelector.delegate = self
    }
    
    func shotSelector(selector: ShotSelectorView, shotSelected shot: String) {
//        shotsLabel.text = (shotsLabel.text ?? "") + shot + " "
    }
}
