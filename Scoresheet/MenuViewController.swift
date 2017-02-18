//
//  MenuViewController.swift
//  Scoresheet
//
//  Created by Jack Cook on 2/18/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var topBarBottomBorder: CALayer!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if topBarBottomBorder == nil {
            topBarBottomBorder = CALayer()
            topBarBottomBorder.backgroundColor = UIColor(red: 229/255, green: 115/255, blue: 115/255, alpha: 1).cgColor
            topBar.layer.addSublayer(topBarBottomBorder)
        }
        topBarBottomBorder.frame = CGRect(x: 0, y: topBar.frame.size.height - 1, width: topBar.frame.size.width, height: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "Test")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("MenuHeaderView", owner: self, options: nil)![0] as! MenuHeaderView
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
