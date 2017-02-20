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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var games = [(Game, Date)]()
    
    private var dateSortedGames: [(String, [Game])] {
        let today = games.filter { game, date -> Bool in
            return Calendar.current.dateComponents([.day], from: date) == Calendar.current.dateComponents([.day], from: Date())
        }
        
        var todayGames = [Game]()
        
        for (game, _) in today {
            todayGames.append(game)
        }
        
        let yesterday = games.filter { game, date -> Bool in
            if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
                return Calendar.current.dateComponents([.day], from: date) == Calendar.current.dateComponents([.day], from: yesterday)
            }
            
            return false
        }
        
        var yesterdayGames = [Game]()
        
        for (game, _) in yesterday {
            yesterdayGames.append(game)
        }
        
        let thisWeek = games.filter { game, date -> Bool in
            return Date().timeIntervalSince1970 - date.timeIntervalSince1970 < 7 * 24 * 60 * 60
                && !todayGames.contains { $0 == game }
                && !yesterdayGames.contains { $0 == game }
        }
        
        var thisWeekGames = [Game]()
        
        for (game, _) in thisWeek {
            thisWeekGames.append(game)
        }
        
        let thisMonth = games.filter { game, date -> Bool in
            return Date().timeIntervalSince1970 - date.timeIntervalSince1970 < 30 * 24 * 60 * 60
                && Date().timeIntervalSince1970 - date.timeIntervalSince1970 > 7 * 24 * 60 * 60
        }
        
        var thisMonthGames = [Game]()
        
        for (game, _) in thisMonth {
            thisMonthGames.append(game)
        }
        
        let distantPast = games.filter { game, date -> Bool in
            return Date().timeIntervalSince1970 - date.timeIntervalSince1970 > 30 * 24 * 60 * 60
        }
        
        var distantPastGames = [Game]()
        
        for (game, _) in distantPast {
            distantPastGames.append(game)
        }
        
        var sortedGames = [(String, [Game])]()
        
        if todayGames.count > 0 {
            sortedGames.append(("Today", todayGames))
        }
        
        if yesterdayGames.count > 0 {
            sortedGames.append(("Yesterday", yesterdayGames))
        }
        
        if thisWeekGames.count > 0 {
            sortedGames.append(("This week", thisWeekGames))
        }
        
        if thisMonthGames.count > 0 {
            sortedGames.append(("This month", thisMonthGames))
        }
        
        if distantPastGames.count > 0 {
            sortedGames.append(("Distant past", distantPastGames))
        }
        
        return sortedGames
    }
    
    private var topBarBottomBorder: CALayer!
    
    private var gameToSend: Game?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadGames()
        
        newButton.setImage(newButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        newButton.tintColor = .white
        
        tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        tableView.tableHeaderView = dummyView
        tableView.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadGames()
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
    
    func reloadGames() {
        games = [(Game, Date)]()
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: documentsDirectory)
            
            for file in files {
                let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let filePath = "\(documentsDirectory)/\(file)"
                
                if let game = Game(filePath: filePath),
                    let date = try FileManager.default.attributesOfItem(atPath: filePath)[.creationDate] as? Date {
                    
                    games.append((game, date))
                }
            }
            
            tableView.reloadData()
        } catch {}
    }
    
    @IBAction func newButtonPressed(sender: UIButton) {
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gvc = segue.destination as? GameViewController {
            gvc.game = gameToSend ?? Game()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateSortedGames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSortedGames[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MenuCell", owner: self, options: nil)![0] as! MenuCell
        cell.configure(dateSortedGames[indexPath.section].1[indexPath.row])
        
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
        header.titleLabel.text = dateSortedGames[section].0
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
        
        gameToSend = dateSortedGames[indexPath.section].1[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
}
