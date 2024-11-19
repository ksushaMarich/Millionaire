//
//  AnswerTextFeldCell.swift
//  TextFieldProject
//
//  Created by Ксения Маричева on 10.09.2024.
//

import UIKit

class AnswerTextFeldCell: UICollectionViewCell {
    
    //MARK: - name
    static var identifier = "AnswerTextFeldCell"
    
    var hasAnswer: Bool {
        textFeld.hasText
    }
    
    var answer: String {
        textFeld.text ?? ""
    }
    
    private lazy var textFeld: QuestionTextFeld = {
        let textFeld = QuestionTextFeld()
        textFeld.translatesAutoresizingMaskIntoConstraints = false  
        return textFeld
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textFeld.text = ""
        textFeld.setDeselected()
    }
    
    private func setupCell() {
        contentView.addSubview(textFeld)
        
        NSLayoutConstraint.activate([
            textFeld.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFeld.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textFeld.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFeld.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func setPlaceholder(_ placeholder: String) {
        textFeld.setPlaceholder(placeholder)
    }
    
    func markCorrect() {
        textFeld.setSelected()
    }
    
    func markWrong() {
        textFeld.setDeselected()
    }
}
