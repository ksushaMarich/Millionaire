//
//  PhotoCell.swift
//  UICollectionView
//
//  Created by Ksenia Maricheva on 05.06.2024.
//

import UIKit

class AnswerCell: UICollectionViewCell {
    
    //MARK: - naming
    
    static var identifier = "AnswerCell"
    
    private let answerColor: UIColor = .gameGray
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = answerColor
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Fonts.main
        label.textColor = .gameLiteGray
        return label
    }()
    
    //MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleView.backgroundColor = answerColor
        titleLabel.textColor = .gameLiteGray
        isUserInteractionEnabled = true
    }
    
    func setup() {
        
        titleView.addSubview(titleLabel)
        contentView.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor)
        ])
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
    
    func fadeElements() {
        titleView.backgroundColor = .clear
        titleLabel.textColor = .clear
        isUserInteractionEnabled = false
    }
    
    func selectCell() {
        titleView.backgroundColor = .badGame
    }
}

