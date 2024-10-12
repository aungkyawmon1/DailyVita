//
//  FinalOutputModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

// Final Output Model
struct FinalOutputVO: Codable {
    let health_concerns: [HealthConcernVO]
    let diets: [DietVO]
    let is_daily_exposure: Bool
    let is_smoke: Bool
    let alcohol: String
    let allergies: [AllergeyVO]
}
