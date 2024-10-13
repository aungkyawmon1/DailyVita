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
    
    var didTapInfo: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapInfo = UITapGestureRecognizer(target: self, action: #selector(onTapInfo))
        ivInfo.isUserInteractionEnabled = true
        ivInfo.addGestureRecognizer(tapInfo)
    }
    
    func setupData(name: String, isChecked: Bool, isNone: Bool) {
        
        ivCheckBox.image = isChecked ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        lblName.text = name
        ivInfo.isHidden = !isNone
    }

    @objc
    func onTapInfo() {
        didTapInfo?()
    }
}
