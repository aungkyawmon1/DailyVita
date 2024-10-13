//
//  DailyRoutine.swift
//  DailyVita
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

class DailyRoutineViewModel: BaseViewModel {
    
    let getPersonzlzedVitamin: GetPersonalizedVitaminResponder
    let stateManagementResponder: StateManagementResponder
    
    @Published public private(set) var buttonEnabled = false
    
    var questions: [DailyRoutineQuestionVO] = [
        DailyRoutineQuestionVO(title: "Is your daily exposure to sun limited? *", key: "is_daily_exposure", options: ["Yes", "No"], type: .trueFalse),
        DailyRoutineQuestionVO(title: "Do you currently smoke (tobacco or marijuana)? *",key: "is_somke", options: ["Yes", "No"], type: .trueFalse),
        DailyRoutineQuestionVO(title: "On average, how many alcoholic beverages do you have in a week? *",key: "alchol", options: ["0 - 1", "2 - 5", "5+"], type: .multipleChoice)
       ]
    
    init(getPersonzlzedVitamin: GetPersonalizedVitaminResponder, stateManagementResponder: StateManagementResponder) {
        self.getPersonzlzedVitamin = getPersonzlzedVitamin
        self.stateManagementResponder = stateManagementResponder
        super.init()
    }
    
    @objc
    func onTapGetPersonalizedVitamin() {
        stateManagementResponder.saveDailyRoutine(questions)
        getPersonzlzedVitamin.getPersonalizedVitamin()
    }
    
    func selectQuestion(at section: Int, selectedIndex: Int) {
        let question = questions[section]

        switch question.type {
        case .trueFalse:
            // Assuming a boolean value based on which row is tapped (e.g., Yes/No)
            let isTrue = selectedIndex == 0
            questions[section].selectedOption = .boolean(isTrue)
            
            
        case .multipleChoice:
            let selectedOption = question.options[selectedIndex]
            questions[section].selectedOption = .string(selectedOption)
        }
        
        questions[section].selectedIndex = selectedIndex
        checkButtonState()

    }
    
    func checkButtonState() {
        var state: Bool = true
        for question in questions {
            if question.selectedOption == nil {
                state = false
                break
            }
        }
        buttonEnabled = state
    }
}
