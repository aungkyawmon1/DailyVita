//
//  MainViewController.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import Combine

class MainViewController: BaseViewController {

    let viewModel: MainViewModel
    
    // State
    private var subscriptions = Set<AnyCancellable>()
    
    // Child View Controllers
    let welcomeViewController: WelcomeViewController
    let healthConcernViewController: HealthConcernViewController
    let dietViewController: DietViewController
    let dailyRoutineViewController: DailyRoutineViewController
    let allergyViewController: AllergeyViewController
    var currentViewController: UIViewController?

    init(viewModel: MainViewModel,
         welcomeViewController: WelcomeViewController,
         healthConcernViewController: HealthConcernViewController,
         dietViewController: DietViewController,
         dailyRoutineViewController: DailyRoutineViewController,
         allergyViewController: AllergeyViewController) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        self.healthConcernViewController = healthConcernViewController
        self.dietViewController = dietViewController
        self.dailyRoutineViewController = dailyRoutineViewController
        self.allergyViewController = allergyViewController
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe(to: viewModel.$view.eraseToAnyPublisher())
    }
    
    func subscribe(to publisher: AnyPublisher<MainView, Never>) {
      publisher
        .receive(on: DispatchQueue.main)
        .sink { [weak self] view in
          self?.present(view)
        }.store(in: &subscriptions)
    }
    
    func present(_ view: MainView) {
      switch view {
      case .welcome:
          presentWelcomeScreen()
      case .healthConcern:
          presentHealthConcernScreen()
      case .diet:
          presentDietScreen()
      case .dailyRoutine:
          presentDailyRoutineScreen()
      case .allergey:
          presentAllergyScreen()
      }
    }
    
    func presentWelcomeScreen() {
        remove(childViewController: currentViewController)
        currentViewController = welcomeViewController
        addFullScreen(childViewController: currentViewController!)
    }
    
    func presentHealthConcernScreen() {
        remove(childViewController: currentViewController)
        currentViewController = healthConcernViewController
        addFullScreen(childViewController: currentViewController!)
    }
    
    func presentDietScreen() {
        remove(childViewController: currentViewController)
        currentViewController = dietViewController
        addFullScreen(childViewController: currentViewController!)
    }
    
    func presentAllergyScreen() {
        remove(childViewController: currentViewController)
        currentViewController = allergyViewController
        addFullScreen(childViewController: currentViewController!)
    }
    
    func presentDailyRoutineScreen() {
        remove(childViewController: currentViewController)
        currentViewController = dailyRoutineViewController
        addFullScreen(childViewController: currentViewController!)
    }

}
