//
//  MainViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import Combine

class MainViewModel {
    
    @Published public private(set) var view: MainView
    
    var healthConcern: [HealthConcernVO] = []
    var diets: [DietVO] = []
    var dailyRoutines: [DailyRoutineQuestionVO] = []
    var allegeries: [AllergeyVO] = []
    
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
    
    func getPersonalizedVitamin() {
        debugPrintFinalOutput(finalOutput: FinalOutputVO(health_concerns: healthConcern, diets: diets, dailyRoutine: dailyRoutines, allergies: allegeries))
    }
    
    func debugPrintFinalOutput(finalOutput: FinalOutputVO) {
        finalOutput.showPersonalizedData()
        
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        
//        do {
//            let jsonData = try encoder.encode(finalOutput)
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                debugPrint(jsonString) // This will print the JSON structure as requested
//            }
//        } catch {
//            print("Failed to encode final output: \(error)")
//        }
    }
    
    func saveHealthConcerns(_ healthConcerns: [HealthConcernVO]) {
        self.healthConcern = healthConcerns
    }
    
    func saveDiets(_ diets: [DietVO]) {
        self.diets = diets
    }
    
    func saveAllergies(_ allergies: [AllergeyVO]) {
        self.allegeries = allergies
    }
    
    func saveDailyRoutine(_ dailyRoutine: [DailyRoutineQuestionVO]) {
        self.dailyRoutines = dailyRoutine
    }
    
}

extension MainViewModel:  WelcomeResponder, HealthConcernResponder, DietResponder, DailyRoutineResponder, AllergeyResponder, GetPersonalizedVitaminResponder, StateManagementResponder { }
