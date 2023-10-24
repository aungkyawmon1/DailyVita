//
//  HealthConcern.swift
//  DailyVita
//
//  Created by solinx on 24/10/2023.
//

import Foundation

struct HealthConcernData: Codable {
    let data: [HealthConcern]
}


struct HealthConcern: Codable {
    let id: Int
    let name: String
}
