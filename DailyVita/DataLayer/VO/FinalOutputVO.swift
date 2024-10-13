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
    let dailyRoutine: [DailyRoutineQuestionVO]
    let allergies: [AllergeyVO]
    
    func showPersonalizedData() {
        print("{\n")
        print("\thealth_concerns: [\n")
        health_concerns.forEach {
            print("\t\t{\n")
            print("\t\tid: \($0.id),\n")
            print("\t\tname: \($0.name),\n")
            print("\t\tpriotity: \($0.priority ?? 0)\n")
            print("\t\t},\n")
        }
        print("\t],\n\tdiets: [\n")
        diets.forEach {
            print("\t\t{\n")
            print("\t\tname: \($0.name)\n")
            print("\t\t}\n")
        }
        print("\t],\n")
        dailyRoutine.forEach{
            // Access selected option:
            if case let .boolean(value) = $0.selectedOption {
                print("\t\($0.key): \(value),\n")
            }

            if case let .string(option) = $0.selectedOption {
                print("\t\($0.key): \(option),\n")
            }
        }
        print("\t\n\tallergies: [\n")
        allergies.forEach {
            print("\t\t{\n")
            print("\t\tid: \($0.id),\n")
            print("\t\tname: \($0.name)\n")
            print("\t\t}\n")
        }
        print("\t]\n")
    }
}
