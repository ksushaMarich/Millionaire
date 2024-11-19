//
//  Game.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 21.05.2024.
//

import UIKit


protocol GameDelegate: AnyObject {
    func next()
    func end(result: Int)
    func updateProgress(numOfQuestion: Int, percent: Double)
}

class Game {
    
    //MARK: - naming
    
    static let shared = Game()
    
    var gameSession: GameSession? = nil {
        didSet {
            addObservers()
        }
    }
    
    weak var delegate: GameDelegate?
    
    private(set) var shuffled: Bool
    let shuffleValueKeeper = ValueKeeper<Bool>(key: "shuffled")
    
    var finalQuestions: [Question] {
        let strategy: ShuffleStrategy = shuffled ? RandomStrategy() : SequentialStrategy()
        return strategy.process(questions: questions + userQuestions)
    }
    
    // MARK: - records data
    
    let recordsKeeper = Keeper<RecordsOriginator>()
    private(set) var records: [RecordsOriginator] = []
    
    // MARK: - user added questions data
    
    let userQuestionsKeeper = Keeper<Question>()
    private(set) var userQuestions: [Question] = []
    
    private var progressPercent: Double? {
        guard let session = gameSession else { return nil}
        return Double(session.numberOfCorrectAnswers.value)/Double(session.questions.count)
    }
    
    //MARK: - initialization
    
    private init() {
        records = recordsKeeper.load()
        shuffled = shuffleValueKeeper.load() ?? false
        
        userQuestions = userQuestionsKeeper.load()
    }
    
    // MARK: - Game Management
    
    func addObservers() {
        gameSession?.numberOfCorrectAnswers.bind { value in
            guard let progress = self.progressPercent else { return }
            self.delegate?.updateProgress(numOfQuestion: value + 1, percent: progress)
        }
    }
    
    func checkAnswer(at index: Int) {
        guard let session = gameSession else { return }
        if index == session.currentQuestion.correctAnswerIndex {
            gameSession?.addCorrectAnswer()
            session.isLastQuestion ? endGame(won: true) : delegate?.next()
        } else { endGame(won: false) }
    }
    
    func endGame(won: Bool) {
        guard let progressPercent else { return }
        let percent = Int(progressPercent * 100)
        records.append(RecordsOriginator(score: percent, date: Date.formattedString))
        recordsKeeper.save(records)
        delegate?.end(result: percent)
        gameSession = nil
    }
    
    // MARK: - Data Management
    
    func removeRecords() {
        records = []
        recordsKeeper.save(records)
    }
    
    func deleteUserQuestion(question: Question) {
        userQuestions.removeAll(where: { $0 == question })
        userQuestionsKeeper.save(userQuestions)
    }
    
    func changeShuffleMode(_ value: Bool) {
        shuffled = value
        shuffleValueKeeper.save(shuffled)
    }
    
    func saveUserQuestion(_ question: Question) {
        userQuestions.append(question)
        userQuestionsKeeper.save(userQuestions)
    }
}

extension Date {
    static var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: Date())
    }
}

