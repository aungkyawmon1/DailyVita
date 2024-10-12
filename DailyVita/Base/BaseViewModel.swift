//
//  BaseViewModel.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class BaseViewModel {
    // Function to load the JSON from the file in your app bundle
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to locate \(fileName).json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to decode \(fileName).json: \(error.localizedDescription)")
            return nil
        }
    }

}
