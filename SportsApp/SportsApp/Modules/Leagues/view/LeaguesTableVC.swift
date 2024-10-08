//
//  LeaguesTableVC.swift
//  SportsApp
//
//  Created by Shady Adel on 14/08/2024.
//

import UIKit
import Kingfisher
import Alamofire


class LeaguesTableVC: UITableViewController {
    var sport: String?
    
    var leaguesArray = [League]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
      
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        //FIXME: move to model
        let baseUrl = URL(string: "https://apiv2.allsportsapi.com/\(sport ??  "football")/?met=Leagues&APIkey=76a51d962bba98945a8f0f16a8b272400dfcea841cf0b303f9ab3c6e20aaee0f")
        AF.request(baseUrl!).responseDecodable(of: LeagueResponse.self) { response in
            switch response.result {
            case .success(let leagueResponse):
                self.leaguesArray = leagueResponse.result
                self.tableView.reloadData()
                //                for league in leagueResponse.result {
                //                    if let logo = league.leagueLogo {
                //                        print("League: \(league.leagueName), Logo: \(logo)")
                //                    } else {
                //                        print("League: \(league.leagueName), Logo: Not available")
                //                    }
                //                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.img.layer.cornerRadius = cell.img.frame.size.height / 2
        cell.img.layer.masksToBounds = true
        
        cell.lbl.text = leaguesArray[indexPath.row].leagueName
        //FIXME: apply mvvm
        let url = URL(string: leaguesArray[indexPath.row].leagueLogo ?? "")
        if url != nil {
            cell.img.kf.setImage(with: url, placeholder: UIImage(named: sport!))
        } else {
            cell.img.image = UIImage(named: sport!)
        }
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(youtubeButtonTapped(_:)), for: .touchUpInside)
        
        cell.layer.cornerRadius = cell.frame.height / 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsVC
        leagueDetails.sport = sport
        leagueDetails.league = leaguesArray[indexPath.row]
        present(leagueDetails, animated: true)
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
