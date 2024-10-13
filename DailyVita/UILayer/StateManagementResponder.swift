//
//  StateManagementResponder.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 13/10/2567 BE.
//

import Foundation

protocol StateManagementResponder {
    func saveHealthConcerns(_ healthConcerns: [HealthConcernVO])
    func saveDiets(_ diets: [DietVO])
    func saveAllergies(_ allergies: [AllergeyVO])
    func saveDailyRoutine(_ dailyRoutine: [DailyRoutineQuestionVO])
}
