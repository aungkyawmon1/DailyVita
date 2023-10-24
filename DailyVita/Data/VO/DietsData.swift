//
//  Diets.swift
//  DailyVita
//
//  Created by solinx on 24/10/2023.
//

import Foundation

// MARK: - Welcome
struct DietsData: Codable {
    let data: [DietVO]
}

// MARK: - Datum
struct DietVO: Codable {
    let id: Int
    let name, toolTip: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case toolTip = "tool_tip"
    }
}

let diet: DietsData = Bundle.main.decode("Diets.json")
