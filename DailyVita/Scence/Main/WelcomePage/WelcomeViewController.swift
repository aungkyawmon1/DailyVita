//
//  WelcomeViewController.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var lblWelcome: UILabel!
    
    let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    func setupUI() {
        btnGetStarted.layer.cornerRadius = 10
        btnGetStarted.addTarget(viewModel, action: #selector(WelcomeViewModel.onTapGetStarted), for: .touchUpInside)
    }

}
