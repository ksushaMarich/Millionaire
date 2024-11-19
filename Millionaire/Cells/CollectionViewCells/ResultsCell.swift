//
//  ResultsCell.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 07.06.2024.
//

import UIKit

class ResultsCell: UICollectionViewCell {
    
    //MARK: - naming
    
    static var identifier = "ResultsCell"
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gameDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    //MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    private func setupCell() {
        
        backgroundColor = .systemGray3
        layer.masksToBounds = true
        layer.cornerRadius = 14
        
        contentView.addSubview(colorView)
        contentView.addSubview(resultLabel)
        contentView.addSubview(gameDateLabel)
        
        NSLayoutConstraint.activate([
            
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            resultLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            gameDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            gameDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gameDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
        ])
    }
    
    func configure(result: RecordsOriginator) {
        
        gameDateLabel.text = "\(result.date)"
        resultLabel.text = "\(result.score)%"
        
        colorView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Double(result.score)/100).isActive = true
        setNeedsLayout()
        layoutIfNeeded()
        
        let colorName: String
        
        switch result.score {
        case 0..<40:    colorName = "Lose_Color"
        case 40..<70:   colorName = "Bad_Game"
        default:        colorName = "Win_Color"
        }
        
        colorView.backgroundColor = UIColor(named: colorName)
    }
}
