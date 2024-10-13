//
//  DailyVitaAppDependencyContainer.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class DailyVitaAppDependencyContainer {
    let sharedViewModel: MainViewModel
    
    init() {
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        
        self.sharedViewModel = makeMainViewModel()
    }
    
    
    func makeMainViewController() -> MainViewController {
        let makeWelcomeViewController = makeWelcomeViewController()
        let healthConcernViewController = makeHealthConcernViewController()
        let dietViewController = makeDietViewController()
        let dailyRoutineViewController = makeDailyRoutineViewController()
        let allergeyViewController = makeAllergyViewController()
        return MainViewController(
            viewModel: sharedViewModel,
            welcomeViewController: makeWelcomeViewController,
            healthConcernViewController: healthConcernViewController,
            dietViewController: dietViewController,
            dailyRoutineViewController: dailyRoutineViewController,
            allergyViewController: allergeyViewController)
    }
    
    func makeWelcomeViewController() -> WelcomeViewController {
        let makeWelcomeViewModel = makeWelcomeViewModel()
        return WelcomeViewController(viewModel: makeWelcomeViewModel)
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        return WelcomeViewModel(healthConcernResponder: sharedViewModel)
    }
    
    func makeHealthConcernViewController() -> HealthConcernViewController {
        let makeHealthConcernViewModel = makeHealthConcernViewModel()
        return HealthConcernViewController(viewModel: makeHealthConcernViewModel)
    }
    
    func makeHealthConcernViewModel() -> HealthConcernViewModel {
        return HealthConcernViewModel(welcomeResponder: sharedViewModel, dietResponder: sharedViewModel, stateMangementResponder: sharedViewModel)
    }
    
    func makeDietViewController() -> DietViewController {
        let makeDietViewModel = makeDietViewModel()
        return DietViewController(viewModel: makeDietViewModel)
    }
    
    func makeDietViewModel() -> DietViewModel {
        return DietViewModel(healthConcernResponder: sharedViewModel, allergeyResponder: sharedViewModel, stateManagementResponder: sharedViewModel)
    }
    
    func makeDailyRoutineViewController() -> DailyRoutineViewController {
        let makeDailyRoutineViewModel = makeDailyRoutineViewModel()
        return DailyRoutineViewController(viewModel: makeDailyRoutineViewModel)
    }
    
    func makeDailyRoutineViewModel() -> DailyRoutineViewModel {
        return DailyRoutineViewModel(getPersonzlzedVitamin: sharedViewModel, stateManagementResponder: sharedViewModel)
    }
    
    func makeAllergyViewController() -> AllergeyViewController {
        let makeAllergyViewModel = makeAllergyViewModel()
        return AllergeyViewController(viewModel: makeAllergyViewModel)
    }
    
    func makeAllergyViewModel() -> AllergeyViewModel {
        return AllergeyViewModel(dailyRoutineResponder: sharedViewModel, dietResponder: sharedViewModel, stateManagementResponder: sharedViewModel)
    }
}
