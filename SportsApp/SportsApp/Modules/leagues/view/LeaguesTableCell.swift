//
//  LeaguesTableCell.swift
//  SportsApp
//
//  Created by Shady Adel on 14/08/2024.
//

import UIKit

class LeaguesTableCell: UITableViewCell {

    @IBOutlet weak var imgLeagueTableVCImage: UIImageView!
    
    @IBOutlet weak var lblLeagueTableVCLabel: UILabel!
    
    @IBOutlet weak var btnLeagueTableVCButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
