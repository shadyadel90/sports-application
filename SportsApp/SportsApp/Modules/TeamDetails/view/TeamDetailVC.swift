//
//  TeamDetailVC.swift
//  SportsApp
//
//  Created by Shady Adel on 20/08/2024.
//

import UIKit

class TeamDetailVC: UIViewController {

    var team: Team?
    
    @IBOutlet weak var imgTeamDetail: UIImageView!
    @IBOutlet weak var lblleagueName: UILabel!
    
    @IBOutlet weak var lblTeamName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTeamName.text = team?.name
        let url = URL(string: (team?.logo)!)
        if url != nil {
            imgTeamDetail.kf.setImage(with: url, placeholder: UIImage(named: "football"))
        } else {
            imgTeamDetail.image = UIImage(named: "football")
        }

    }
    

   

}
