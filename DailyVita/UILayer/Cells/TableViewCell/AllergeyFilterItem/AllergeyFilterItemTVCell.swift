//
//  AllergeyFilterItemTVCell.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 13/10/2567 BE.
//

import UIKit

class AllergeyFilterItemTVCell: UITableViewCell {
    
    @IBOutlet weak var lblAllergey: UILabel!
    
    var allergyVO: AllergeyVO? {
        didSet {
            lblAllergey.text = allergyVO?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
