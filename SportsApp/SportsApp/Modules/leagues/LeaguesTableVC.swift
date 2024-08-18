//
//  LeaguesTableVC.swift
//  SportsApp
//
//  Created by Shady Adel on 14/08/2024.
//

import UIKit

class LeaguesTableVC: UITableViewController {
    var sport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableCell
        
        cell.imgLeagueTableVCImage.layer.cornerRadius = cell.imgLeagueTableVCImage.frame.size.height / 2
        cell.imgLeagueTableVCImage.layer.masksToBounds = true
        
        cell.lblLeagueTableVCLabel.text = sport
        
        
        return cell
    }
    
    
   
    
}
