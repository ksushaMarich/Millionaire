//
//  GameViewController.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 16.05.2024.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func configureNextQuestion()
    func configureProgress(numOfQuestion: Int, percent: Double)
    func removeTwoAnswers( _ answersToRemove: [Int])
    func selectHint(_ answerIndex: Int)
}

class GameViewController: UIViewController {
    
    //MARK: - naming
    weak var delegate: GameViewControllerDelegate?
    
    private let game = Game.shared
    
    private lazy var gameSession = GameSession(questions: game.finalQuestions)
    
    private lazy var gameView: GameView = {
        let view = GameView()
        delegate = view
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        

        game.gameSession = gameSession
        game.delegate = self
        setupView()
        delegate?.configureNextQuestion()
    }
    
    //MARK: - functions
    
    private func setupView() {
        view.addSubview(gameView)
        
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func selectHintWithAlert(_ alertData: SingleActionAlertData, hintIndex: Int) {
        let alert = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertData.actionTitle, style: .cancel))
        present(alert, animated: true)
        delegate?.selectHint(hintIndex)
    }
}
  
extension GameViewController: GameViewDelegate {
    
    var currentQuestion: Question {
        gameSession.currentQuestion
    }
    
    func processTap(at index: Int) {
        game.checkAnswer(at: index)
    }
    
    func processHelpTap(at index: Int) {
        let questionFacade = gameSession.hintUsageFacade
        switch index {
        case 0:
            selectHintWithAlert(SingleActionAlertData(title: "Друг поделился ответом!", message: "А если бы он вам сказал спрыгнуть с 10 этажа?", actionTitle: "Спрыгнул бы"), hintIndex: questionFacade.callFriend())
        case 1:
            selectHintWithAlert(SingleActionAlertData(title: "Зал проголосовал!", message: nil, actionTitle: "Ok"), hintIndex: questionFacade.useAuditoryHelp())
        case 2:
            delegate?.removeTwoAnswers(questionFacade.use50to50Hint())
        default: break
        }
    }
}

extension GameViewController: GameDelegate {

    func next() {
        delegate?.configureNextQuestion()
    }
    
    func end(result: Int) {
        navigationController?.pushViewController(EndViewController(result: result), animated: true)
    }
    
    func updateProgress(numOfQuestion: Int, percent: Double) {
        delegate?.configureProgress(numOfQuestion: numOfQuestion, percent: percent)
    }
}
