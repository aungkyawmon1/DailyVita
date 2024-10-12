//
//  DataVO.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

// Container to match the top-level structure of the JSON
struct DataContainer<T: Decodable>: Decodable {
    let data: [T]
}
