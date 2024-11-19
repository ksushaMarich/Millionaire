//
//  UsersQuestionTableViewCell.swift
//  Millionaire
//
//  Created by Ксения Маричева on 30.09.2024.
//

import UIKit

protocol UserQuestionsCellDelegate: AnyObject {
    func deleteQuestion( _ question: Question)
}

protocol ComputedHeight {
    var totalHeight: CGFloat { get }
}


class UserQuestionsCell: UITableViewCell {
    
    //MARK: - naming
    
    static var identifier = "UserQuestionsCell"
    
    weak var delegate: UserQuestionsCellDelegate?
    
    private var question: Question?
    
    static let deleteButtonHeight = CGFloat(20)
    static let questionLabelHeight = CGFloat(100)
    static var answersCollectionViewHeight = CGFloat(AnswersCollectionView.height)
    static let inset = CGFloat(28)
     
    static var totalHeight: CGFloat {
        deleteButtonHeight + questionLabelHeight + answersCollectionViewHeight + inset * 3
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UserQuestionsCell.inset
        return stackView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(deleteQuestion), for: .touchUpInside)
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray3
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var answersCollectionView: AnswersCollectionView = {
        let view = AnswersCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup view methods
    
    private func setupView() {
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(deleteButton)
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(answersCollectionView)
        
        let inset = UserQuestionsCell.inset
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            deleteButton.heightAnchor.constraint(equalToConstant: UserQuestionsCell.deleteButtonHeight),
            
            questionLabel.heightAnchor.constraint(equalToConstant: UserQuestionsCell.questionLabelHeight),
        ])
    }
    
    func configure(with question: Question) {
        self.question = question
        questionLabel.text = question.question
        answersCollectionView.configureAnswers(for: question)
    }
    
    @objc func deleteQuestion() {
        guard let question else { return }
        delegate?.deleteQuestion(question)
    }
    
}
