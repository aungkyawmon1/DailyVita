//
//  DailyRoutineQuestionVO.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 13/10/2567 BE.
//

import Foundation

struct DailyRoutineQuestionVO: Codable {
    let title: String
    let key: String
    let options: [String]
    let type: QuestionType
    var selectedOption: Answer?// To keep track of the user's selection
    var selectedIndex: Int? // To keep track the selected index in each section
}

enum QuestionType: Codable {
    case trueFalse
    case multipleChoice
}

enum Answer: Codable {
    case string(String)
    case boolean(Bool)
}
