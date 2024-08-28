//
//  FavouriteLeagueTableVC.swift
//  SportsApp
//
//  Created by Shady Adel on 20/08/2024.
//

import UIKit

class FavouriteLeagueTableVC: UITableViewController {
    
    var displayLeagues = [League]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Favourite Leagues"
        loadLeagues()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return displayLeagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        let url = URL(string: displayLeagues[indexPath.row].leagueLogo ?? "")
        if url != nil {
            cell.img.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            cell.img.image = UIImage(systemName: "photo")
        }
        cell.lbl.text = displayLeagues[indexPath.row].leagueName
        
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(youtubeButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                CoreDataManager.shared.removeLeague(displayLeagues[indexPath.row])
                displayLeagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    
    func loadLeagues() {
        if let leagueEntities = CoreDataManager.shared.fetchLeagues() {
            let leagues = leagueEntities.map { League(leagueName: $0.leagueName!, leagueLogo: $0.leagueLogo,leagueKey: Int32($0.leagueKey)) }
            self.displayLeagues = leagues
        }
    }
    
    @objc func youtubeButtonTapped(_ sender: UIButton) {
        let videoID = "dQw4w9WgXcQ" // Replace with your video ID
        let urlString = "youtube://www.youtube.com/watch?v=\(videoID)"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Show an alert if the YouTube app is not installed
                let alert = UIAlertController(title: "YouTube App Not Found",
                                              message: "The YouTube app is not installed on your device. Please install the app to view the video.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

