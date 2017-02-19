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
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var topBarBottomBorder: CALayer!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
    
    @IBAction func newButtonPressed(sender: UIButton) {
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MenuCell", owner: self, options: nil)![0] as! MenuCell
        
        if indexPath.row == 0 {
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.roundCorners(.both)
            } else {
                cell.roundCorners(.top)
            }
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.roundCorners(.bottom)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("MenuHeaderView", owner: self, options: nil)![0] as! MenuHeaderView
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
}
