//
//  HealthConcernCVCell.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

class HealthConcernCVCell: UICollectionViewCell {
    
    @IBOutlet weak var lblHealthConcern: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 25
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.selected.cgColor
        containerView.clipsToBounds = true
    }
 
      func isSelectedItem(_ isSelected: Bool)
      {
          containerView.backgroundColor = isSelected ? .selected : .clear
          lblHealthConcern.textColor = isSelected ? .white : .selected
      }


}
