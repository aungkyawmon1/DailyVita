//
//  DietViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class DietViewModel: BaseViewModel {
    
    let healthConcernResponder: HealthConcernResponder
    let allergeyResponder: AllergeyResponder
    
    public private(set) var isSelectedNone: Bool = false
    
    @Published public private(set) var dietData: [DietVO] = [DietVO(id: 0, name: "None", tool_tip: "")]
    @Published public private(set) var buttonEnabled = false
    var selectedDietData: [DietVO] = []
    
    init(healthConcernResponder: HealthConcernResponder, allergeyResponder: AllergeyResponder) {
        self.healthConcernResponder = healthConcernResponder
        self.allergeyResponder = allergeyResponder
        super.init()
        self.loadHealthConcernList()
    }
    
    func loadHealthConcernList() {
        if let dataContainer: DataContainer = loadJSON(fileName: "diets", type: DataContainer<DietVO>.self) {
            self.dietData.append(contentsOf: dataContainer.data)
        }
    }
    
    @objc
    func onTapBack() {
        healthConcernResponder.navigateToHealthCornern()
    }
    
    @objc
    func onTapNext() {
        allergeyResponder.navigateToAllergey()
    }
    
    func selectItem(at index: Int) {
        if isSelectedNone {
            selectedDietData.removeAll()
        }
        selectedDietData.append(dietData[index])
        buttonEnabled = true
        deselectNone()
    }
    
    func deselectItem(at index: Int) {
        for (i, item) in selectedDietData.enumerated() {
            if item == dietData[index] {
                selectedDietData.remove(at: i)
                break
            }
        }
    }
    
    func removeAllSelectedItems() {
        selectedDietData.removeAll()
        selectedDietData.append(dietData[0])
        selectNone()
    }
    
    func selectNone() {
        isSelectedNone = true
        buttonEnabled = true
    }
    
    func deselectNone() {
        isSelectedNone = false
    }
    
    func isSelectedItem(at index: Int) -> Bool {
        for (_, item) in selectedDietData.enumerated() {
            if item == dietData[index] {
                return true
            }
        }
        return false
    }

}
