//
//  ShotDisplayTableView.swift
//  Scoresheet
//
//  Created by Jack Cook on 06/02/2017.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class ShotDisplayTableView: UITableView, UITableViewDataSource {
    
    var server: Player! {
        didSet {
            reloadData()
        }
    }
    
    var opponent: Player! {
        didSet {
            reloadData()
        }
    }
    
    var shots = [Shot]() {
        didSet {
            reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "ShotCell")
        cell.textLabel?.text = shots[indexPath.row].rawValue
        cell.detailTextLabel?.text = (indexPath.row % 2 == 0 ? server : opponent).name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shots.count
    }
}
