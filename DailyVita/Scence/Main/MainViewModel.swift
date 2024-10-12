//
//  MainViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import Combine

class MainViewModel: WelcomeResponder, HealthConcernResponder, DietResponder, DailyRoutineResponder, AllergeyResponder {
    
    @Published public private(set) var view: MainView
    
    init() {
        self.view = .welcome
    }
    
    func navigateToWelcome() {
        view = .welcome
    }
    
    func navigateToHealthCornern() {
        view = .healthConcern
    }
    
    func navigateToDiet() {
        view = .diet
    }
    
    func navigateToDailyRoutine() {
        view = .dailyRoutine
    }
    
    func navigateToAllergey() {
        view = .allergey
    }
    
    
}
