//
//  WelcomeViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class WelcomeViewModel {
    let healthConcernResponder: HealthConcernResponder
    
    init(healthConcernResponder: HealthConcernResponder) {
        self.healthConcernResponder = healthConcernResponder
    }
    
    @objc
    func onTapGetStarted() {
        healthConcernResponder.navigateToHealthCornern()
    }
}
