//
//  GameView.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 16.05.2024.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    var currentQuestion: Question { get }   // DataSource
    func processTap(at index: Int)
    func processHelpTap(at index: Int)
}

class GameView: UIView {

    //MARK: - naming
    
    weak var delegate: GameViewDelegate?
    
    private var inset: CGFloat = 28
    
#warning("Поменяла вью экрана")
    private lazy var tvView: TvView = {
        let view  = TvView(isCat: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gameGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var helpStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    private var helpButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .limeGreen
        button.tintColor = .black
        return button
    }
    
    private lazy var helpButtons: [UIButton] = [helpButton, helpButton, helpButton]
    
    // MARK: - отображение процента и номера вопроса
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.backgroundColor = .gameLiteGray
        return view
    }()
    
    private lazy var percentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gameMiddleGray
        return view
    }()
    
    private lazy var numOfQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.small
        label.textColor = .gameGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.backgroundColor = .clear
        label.text = "1"
        return label
    }()
    
    private lazy var columnCollectionView: AnswersCollectionView = {
        let view = AnswersCollectionView(question: delegate?.currentQuestion)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.tapDelegate = self
        return view
    }()
    
    //MARK: - initialization
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        setupHelpButtons()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    func setupHelpButtons() {
        
        let buttonsIcons = ["teletype.answer", "person.3.fill", "wand.and.stars.inverse"]
        
        for (index, button) in helpButtons.enumerated() {
            helpStackView.addArrangedSubview(button)
            button.setImage(UIImage(systemName: buttonsIcons[index]), for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(helpButtonTaped), for: .touchUpInside)
        }
    }

    private func setupView() {
        
        addSubview(tvView)
        addSubview(helpStackView)
        addSubview(progressView)
        progressView.addSubview(percentView)
        progressView.addSubview(numOfQuestionLabel)
        
        addSubview(columnCollectionView)
        
        NSLayoutConstraint.activate([
            
            //MARK: - question
            tvView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            tvView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            tvView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tvView.heightAnchor.constraint(equalTo: tvView.widthAnchor, multiplier: 13/17),
            
            // MARK: - numOfQuestion
            progressView.topAnchor.constraint(equalTo: tvView.bottomAnchor, constant: inset),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 30),
            
            percentView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            percentView.topAnchor.constraint(equalTo: progressView.topAnchor),
            percentView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor),
            
            numOfQuestionLabel.topAnchor.constraint(equalTo: progressView.topAnchor),
            numOfQuestionLabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor),
            numOfQuestionLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            numOfQuestionLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            
            //MARK: - help Stack
            helpStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 80),
            helpStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            helpStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            helpStackView.heightAnchor.constraint(equalToConstant: 50),
            
            //MARK: - answers
            columnCollectionView.topAnchor.constraint(equalTo: helpStackView.bottomAnchor, constant: inset),
            columnCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            columnCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            columnCollectionView.heightAnchor.constraint(equalToConstant: AnswersCollectionView.height)
        ])
    }
    
    func configure() {
        guard let question = delegate?.currentQuestion else { return }
        tvView.updateQuestion(question.question)
        columnCollectionView.configureAnswers(for: question)
    }
    
    //MARK: Help
    
    @objc func helpButtonTaped(sender: UIButton) {
        sender.backgroundColor = .clear
        sender.tintColor = .clear
        sender.isEnabled = false
        delegate?.processHelpTap(at: sender.tag)
    }
}

extension GameView: ColumnCollectionViewDelegate {
    func processTap(at index: Int) {
        delegate?.processTap(at: index)
    }
}

extension GameView: GameViewControllerDelegate {
    
    func configureNextQuestion() {
        configure()
    }
    
    func configureProgress(numOfQuestion: Int, percent: Double) {
        numOfQuestionLabel.text = "\(numOfQuestion)"
        percentView.widthAnchor.constraint(equalTo: progressView.widthAnchor, multiplier: percent).isActive = true
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func removeTwoAnswers( _ answersToRemove: [Int]) {
        columnCollectionView.removeTwoAnswers(answersToRemove)
    }
    
    
    func selectHint(_ answer: Int) {
        columnCollectionView.selectHint(answer)
    }
}
