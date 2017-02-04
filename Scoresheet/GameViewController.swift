//
//  GameViewController.swift
//  Scoresheet
//
//  Created by Jack Cook on 04/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreCard: ScoreCardView!
    @IBOutlet weak var firstPlayerShotSelector: ShotSelectorView!
    @IBOutlet weak var secondPlayerShotSelector: ShotSelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}