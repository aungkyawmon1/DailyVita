//
//  HealthConcern.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

// Health Concern Model
struct HealthConcernVO: Codable, Equatable {
    let id: Int
    let name: String
    var priority: Int? // Optional for sorted priority
    
    // Custom equality implementation based on `id` only
    static func == (lhs: HealthConcernVO, rhs: HealthConcernVO) -> Bool {
        return lhs.id == rhs.id
    }
}

