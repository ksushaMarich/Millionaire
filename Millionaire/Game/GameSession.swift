//
//  GameSession.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 21.05.2024.
//

import UIKit

class GameSession {
    
    //MARK: - Naming
    
    let questions: [Question]
    var numberOfCorrectAnswers: Observable<Int> = Observable(value: 0)
    
    var isLastQuestion: Bool {
        numberOfCorrectAnswers.value == questions.count
    }
    
    var currentQuestion: Question {
        questions[numberOfCorrectAnswers.value]
    }
    
    lazy var hintUsageFacade = HintUsageFacade(question: currentQuestion)
    
    //MARK: - Initialization
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    func addCorrectAnswer() {
        numberOfCorrectAnswers.value += 1
        if !isLastQuestion {
            hintUsageFacade.question = currentQuestion
        }
    }
    
}
