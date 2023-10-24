//
//  AllergiesVO.swift
//  DailyVita
//
//  Created by solinx on 24/10/2023.
//

import Foundation

// MARK: - Welcome
struct AllergiesData: Codable {
    let data: [AllergyVO]
}

// MARK: - Datum
struct AllergyVO: Codable {
    let id: Int
    let name: String
}
