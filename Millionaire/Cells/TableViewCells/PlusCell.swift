//
//  PlusCell.swift
//  Millionaire
//
//  Created by Ксения Маричева on 05.10.2024.
//

import UIKit

protocol PlusCellDelegate: AnyObject {
    func switchToNewQuestionFormMode()
}

class PlusCell: UITableViewCell {
    
    // MARK: naming
    
    static let identifier = "PlusCell"
    
    weak var cellDelegate: PlusCellDelegate?
    
    static var totalHeight: CGFloat {
        verticalHeight + inset * 2
    }
    
    static let verticalHeight = CGFloat(60)
    static let inset = CGFloat(28)
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "plus")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusTapped)))
        return imageView
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tintColor = .white
        backgroundColor = .black
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setupView methods
    
    func setupView() {
        contentView.addSubview(plusImageView)
        
        NSLayoutConstraint.activate([
            plusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PlusCell.inset),
//            plusImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            plusImageView.heightAnchor.constraint(equalToConstant: PlusCell.verticalHeight),
        ])
    }
    
    @objc func plusTapped() {
        cellDelegate?.switchToNewQuestionFormMode()
    }
}
