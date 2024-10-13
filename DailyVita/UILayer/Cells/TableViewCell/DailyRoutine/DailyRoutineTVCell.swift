//
//  DailyRoutineTVCell.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

class DailyRoutineTVCell: UITableViewCell {
    
    @IBOutlet weak var ivRaidoButton: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(name: String, isSelected: Bool) {
        lblTitle.text = name
        ivRaidoButton.image = isSelected ? UIImage(named: "ic_radio_fill") : UIImage(named: "ic_radio")
    }
    
}
