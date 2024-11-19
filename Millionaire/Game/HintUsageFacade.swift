//
//  HintUsageFacade.swift
//  Millionaire
//
//  Created by Ксения Маричева on 02.11.2024.
//

import UIKit

class HintUsageFacade {
    
    //MARK: - naming
    
    var question: Question
    
    private var answersIndices: [Int] {
        Array(0..<question.answers.count)
    }
    
    //MARK: - init
    
    init(question: Question) {
        self.question = question
    }
    
    //MARK: - methods for question
    
    func callFriend() -> Int {
        var indices = answersIndices
        indices.remove(at: question.correctAnswerIndex)
        return indices.randomElement() ?? 0
        
    }
    
    func useAuditoryHelp() -> Int {
        let probability: Double = 0.8
        guard Double.random(in: 0...1) < probability else {
            return callFriend()
        }
        return question.correctAnswerIndex
    }
    
    func use50to50Hint() -> [Int] {
        var indicesToRemove = answersIndices
        indicesToRemove.remove(at: question.correctAnswerIndex)
        indicesToRemove.remove(at: answersIndices.randomElement()!)
        return indicesToRemove
    }
}
