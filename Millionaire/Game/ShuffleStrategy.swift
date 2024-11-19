//
//  shuffleStrategy.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 18.06.2024.
//

import UIKit

protocol ShuffleStrategy {
    func process(questions: [Question]) -> [Question]
}

final class RandomStrategy: ShuffleStrategy {
    func process(questions: [Question]) -> [Question] {
        questions.shuffled()
    }
}

final class SequentialStrategy: ShuffleStrategy {
    func process(questions: [Question]) -> [Question] {
        questions
    }
}
