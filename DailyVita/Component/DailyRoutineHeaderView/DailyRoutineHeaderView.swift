//
//  DailyRoutineHeaderView.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 13/10/2567 BE.
//

import UIKit

class DailyRoutineHeaderView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    private func buildView() {
        Bundle.main.loadNibNamed(String(describing: DailyRoutineHeaderView.self), owner: self)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    func setupData(name: String) {
        lblTitle.text = name
    }
    
}
