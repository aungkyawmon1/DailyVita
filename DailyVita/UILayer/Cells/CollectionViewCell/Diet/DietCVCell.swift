//
//  DietCVCell.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

class DietCVCell: UICollectionViewCell {

    @IBOutlet weak var ivCheckBox: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivInfo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(name: String, isChecked: Bool, isNone: Bool) {
        
        ivCheckBox.image = isChecked ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        lblName.text = name
        ivInfo.isHidden = !isNone
    }

}
