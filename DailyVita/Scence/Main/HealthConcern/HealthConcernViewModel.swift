//
//  HealthConcernViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import Combine

class HealthConcernViewModel: BaseViewModel {
    
    let welcomeResponder: WelcomeResponder
    let dietResponder: DietResponder
    let stateManagementResponder: StateManagementResponder
    
    var tempSelectedHealthConcernData: [HealthConcernVO] = []
    
    @Published public private(set) var healthConcernData: [HealthConcernVO] = []
    @Published public private(set) var selectedHealthConcernData: [HealthConcernVO] = []
    @Published public private(set) var buttonEnabled = false
    
    init(welcomeResponder: WelcomeResponder, dietResponder: DietResponder, stateMangementResponder: StateManagementResponder) {
        self.welcomeResponder = welcomeResponder
        self.dietResponder = dietResponder
        self.stateManagementResponder = stateMangementResponder
    
        super.init()
        self.loadHealthConcernList()
    }
   
    func loadHealthConcernList() {
        if let dataContainer: DataContainer = loadJSON(fileName: "health_concern", type: DataContainer<HealthConcernVO>.self) {
            self.healthConcernData.append(contentsOf: dataContainer.data)
        }
    }
    
    @objc
    func onTapBack() {
        welcomeResponder.navigateToWelcome()
    }
    
    @objc
    func onTapNext() {
        stateManagementResponder.saveHealthConcerns(selectedHealthConcernData)
        dietResponder.navigateToDiet()
    }
    
    func addHealthConcern(at item: Int) {
        let currentPriority = tempSelectedHealthConcernData.count + 1
        var currentHealthConcern = healthConcernData[item]
        currentHealthConcern.priority = currentPriority
        tempSelectedHealthConcernData.append(currentHealthConcern)
        selectedHealthConcernData = tempSelectedHealthConcernData
        checkButtonState()
    }
    
    func checkButtonState() {
        buttonEnabled = (!selectedHealthConcernData.isEmpty)
    }

    
    func removeSelectedHealthConcern(at item: Int) {
        for (index, value) in tempSelectedHealthConcernData.enumerated() {
            if value == healthConcernData[item] {
                tempSelectedHealthConcernData.remove(at: index)
                selectedHealthConcernData = tempSelectedHealthConcernData
                checkButtonState()
            }
        }
    }
    
    func removeSelectedHealthConcernBeforeInsert(at index: Int) {
        if tempSelectedHealthConcernData.count > index {
            tempSelectedHealthConcernData.remove(at: index)
        }
    }
    
    func insertSelectedHealthConcern(at item: Int, value: HealthConcernVO) {
        tempSelectedHealthConcernData.insert(value, at: item)
    }
    
    func updateSelectedHealthConcern() {
        selectedHealthConcernData = tempSelectedHealthConcernData
    }
    
    func updatePriorityForHealthConcerns() {
        for (index, _) in tempSelectedHealthConcernData.enumerated() {
            tempSelectedHealthConcernData[index].priority = index + 1
        }
        selectedHealthConcernData = tempSelectedHealthConcernData
    }
    
    func isSelectedValue(at item: Int ) -> Bool {
        for (_, value) in tempSelectedHealthConcernData.enumerated() {
            if value == healthConcernData[item] {
                return true
            }
        }
        return false
    }
    
}
