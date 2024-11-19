//
//  QuestionsData.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 15.05.2024.
//

import UIKit

struct Question: Codable, Hashable {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}

struct SingleActionAlertData {
    let title: String
    let message: String?
    let actionTitle: String
}
    
class QuestionBuilder {
    
    //MARK: - naming
    
    private var question = ""
    private var answers: [String] = []
    private var correctAnswerIndex = 0
    
    //MARK: - bilding methods
    
    func addQuestion(_ question: String) {
        self.question = question
    }
    
    func addAnswers(_ answers: [String]) {
        self.answers = answers
    }
    
    func addCorrectAnswer(_ correctAnswer: Int) {
        self.correctAnswerIndex = correctAnswer
    }
    
    func build() -> Question {
        return Question(question: question, answers: answers, correctAnswerIndex: correctAnswerIndex)
    }
}

let questions = [
    Question(question: "Какая из этих игр появилась первой?", answers: ["Super Mario Bros", "The Legend of Zelda", "Tetris", "Pong "], correctAnswerIndex: 3),
    Question(question: "Кто является главным героем игры The Legend of Zelda?", answers: ["Зельда", "Ганондорф", "Линк", "Марио"], correctAnswerIndex: 2),
    Question(question: "Какой культовый аркадный персонаж должен спасти свою возлюбленную от гигантской обезьяны?", answers: ["Донки Конг", "Марио", "Линк", "Соник"], correctAnswerIndex: 1),
    Question(question: "Какую игру называют «первой видеоигрой» в истории?", answers: ["Pong", "Spacewar!", "Pac-Man", "Donkey Kong"], correctAnswerIndex: 1),
    Question(question: "Какая классическая консоль считается первой с поддержкой игр на картриджах?", answers: ["Atari 2600", "NES", "Sega Genesis", "Commodore 64"], correctAnswerIndex: 0)
]

