//
//  AllergeyItemCVCell.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 13/10/2567 BE.
//

import UIKit

class AllergeyItemCVCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ivDelete: UIImageView!
    
    var tapDeleteItem: ((Int) -> Void)?
    
    var selectedItemAt: Int?
    
    var allegeyData: AllergeyVO? {
        didSet {
            lblTitle.text = allegeyData?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 25
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.selected.cgColor
        containerView.clipsToBounds = true
        
        let tapDelete = UITapGestureRecognizer(target: self, action: #selector(onTapDelete))
        ivDelete.isUserInteractionEnabled = true
        ivDelete.addGestureRecognizer(tapDelete)
    }
    
    @objc
    func onTapDelete() {
        guard let selectedItemAt else { return }
        tapDeleteItem?(selectedItemAt)
    }

}
