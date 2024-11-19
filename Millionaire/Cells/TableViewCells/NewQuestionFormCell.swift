//
//  MainView.swift
//  TextFieldProject
//
//  Created by Ксения Маричева on 10.09.2024.
//

import UIKit

protocol NewQuestionFormCellDelegate: AnyObject {
    func showErrorAlert()
    func saveQuestion(_ question: Question)
}

class NewQuestionFormCell: UITableViewCell {
    
    //MARK: - naming
    
    private let questionBuilder = QuestionBuilder()
    
    static var identifier = "NewQuestionFormCell"
    
    weak var cellDelegate: NewQuestionFormCellDelegate?
    
    private var isRightAnswerSelected = false
    
    
    static var saveButtonButtonHeight = CGFloat(40)
    static var questionTextFieltHeight = CGFloat(100)
    static var answersCollectionViewHeight = NewAnswersCollectionView.height
    static var rightAnswerStackViewHeight = CGFloat(50)
    static var inset = CGFloat(28)
    static var totalHeight: CGFloat {
        saveButtonButtonHeight + questionTextFieltHeight + answersCollectionViewHeight + rightAnswerStackViewHeight + inset * 5
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 28
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray2
        button.setImage(UIImage(systemName: "pencil.tip.crop.circle.badge.plus"), for: .normal)
        button.addTarget(self, action: #selector(saveQuestion), for: .touchUpInside)
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        return button
    }()
    
    private lazy var questionTextFeld: QuestionTextFeld = {
        let textFeld = QuestionTextFeld()
        textFeld.translatesAutoresizingMaskIntoConstraints = false
        textFeld.setPlaceholder("Введите новый вопрос")
        return textFeld
    }()
    
    private lazy var answersCollectionView: NewAnswersCollectionView = {
        let view = NewAnswersCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightAnswerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private var rightAnswerButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemGray2
        button.addTarget(self, action: #selector(rightAnswerSelected), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }
    
    private lazy var rightAnswerButtons: [UIButton] = [rightAnswerButton, rightAnswerButton, rightAnswerButton, rightAnswerButton]
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionTextFeld.text = nil
        answersCollectionView.reloadData()
    }
    
    private func setupView() {
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(questionTextFeld)
        stackView.addArrangedSubview(answersCollectionView)
        stackView.addArrangedSubview(rightAnswerStackView)
        
        for (index, button) in rightAnswerButtons.enumerated() {
            rightAnswerStackView.addArrangedSubview(button)
            button.setTitle("\(index + 1)", for: .normal)
            button.tag = index
        }
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: NewQuestionFormCell.inset),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: NewQuestionFormCell.inset),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: NewQuestionFormCell.saveButtonButtonHeight),
            
            questionTextFeld.heightAnchor.constraint(equalToConstant: NewQuestionFormCell.questionTextFieltHeight),
            
            rightAnswerStackView.heightAnchor.constraint(equalToConstant: NewQuestionFormCell.rightAnswerStackViewHeight),
        ])
    }
    
    @objc func rightAnswerSelected(selector: UIButton) {
        
        endEditing(true)
        
        isRightAnswerSelected = true
        let index = selector.tag
        
        answersCollectionView.markRightAnswer(index)
        
        questionBuilder.addCorrectAnswer(index)
    }
    
    @objc func saveQuestion() {
        
        guard let question = questionTextFeld.text,
                !question.isEmpty, isRightAnswerSelected,
              answersCollectionView.hasAnswers
        else {
            cellDelegate?.showErrorAlert()
            return
        }
        
        questionBuilder.addQuestion(question)
        questionBuilder.addAnswers(answersCollectionView.answers)
        
        cellDelegate?.saveQuestion(questionBuilder.build())
    }
}
