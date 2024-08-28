//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Shady Adel on 20/08/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
  
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
