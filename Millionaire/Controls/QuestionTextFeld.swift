//
//  NewQuestionTextFeld.swift
//  Sample
//
//  Created by Ксения Маричева on 09.09.2024.
//

import UIKit

class QuestionTextFeld: UITextField {
    
    //MARK: - naming
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    private let selectedColor = UIColor(named: "Win_Color")
    private let deselectedColor = UIColor.systemGray3
    
     //MARK: - initialization
    
    init() {
        super.init(frame: .zero)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField() {
        layer.cornerRadius = 14
        setDeselected()
        font = .systemFont(ofSize: 22, weight: .medium)
        textAlignment = .center
        textColor = .black
    }
    
    //MARK: - public methods
    
    func setPlaceholder(_ placeholder: String) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
    }
    
    func setSelected() {
        backgroundColor = selectedColor
    }
    
    func setDeselected() {
        backgroundColor = deselectedColor
    }
}
