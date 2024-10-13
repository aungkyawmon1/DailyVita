//
//  AllergeyViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class AllergeyViewModel: BaseViewModel {
    
    let dailyRoutineResponder: DailyRoutineResponder
    let dietResponder: DietResponder
    let stateManagementResponder: StateManagementResponder
    
    private(set) var autoCompleteItems: [AllergeyVO] = []
    @Published public private(set) var filteredItems: [AllergeyVO] = []
    @Published public private(set) var selectedItems: [AllergeyVO] = []
    
    init(dailyRoutineResponder: DailyRoutineResponder, dietResponder: DietResponder, stateManagementResponder: StateManagementResponder) {
        self.dailyRoutineResponder = dailyRoutineResponder
        self.dietResponder = dietResponder
        self.stateManagementResponder = stateManagementResponder
        super.init()
        loadAllergeyList()
    }
    
    func loadAllergeyList() {
        if let dataContainer: DataContainer = loadJSON(fileName: "allergies", type: DataContainer<AllergeyVO>.self) {
            self.autoCompleteItems.append(contentsOf: dataContainer.data)
        }
    }
    
    @objc
    func onTapBack() {
        dietResponder.navigateToDiet()
    }
    
    @objc
    func onTapNext() {
        stateManagementResponder.saveAllergies(selectedItems)
        dailyRoutineResponder.navigateToDailyRoutine()
    }
    
    // Filter autocomplete suggestions based on the input
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredItems.removeAll()
        } else {
            filteredItems = autoCompleteItems.filter { item in
                // Filter by search text and exclude already selected items
                return item.name.lowercased().contains(searchText.lowercased()) && !selectedItems.contains(where: { $0.name == item.name })
            }
        }
    }
        
        func selectedAllergey(at index: Int) {
            let selectedItem = filteredItems[index]
            selectedItems.append(selectedItem)
            filteredItems.removeAll()
        }
        
        func removeSelectedAllergey(at index: Int) {
            selectedItems.remove(at: index)
        }
    }
