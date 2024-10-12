//
//  DietModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

// Diet Model
struct DietVO: Codable, Equatable {
    let id: Int
    let name: String
    let tool_tip: String
    
    // Custom equality implementation based on `id` only
    static func == (lhs: DietVO, rhs: DietVO) -> Bool {
        return lhs.id == rhs.id
    }
}
