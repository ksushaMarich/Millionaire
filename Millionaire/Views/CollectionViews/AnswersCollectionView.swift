//
//  ButtonCollectionView.swift
//  Drochilnia
//
//  Created by Ksenia Maricheva on 06.06.2024.
//

import UIKit

protocol ColumnCollectionViewDelegate: AnyObject {
    func processTap(at index: Int)
}

class AnswersCollectionView: ColumnCollectionView {
    
    //MARK: - naming
    
    weak var tapDelegate: ColumnCollectionViewDelegate?
    
    private var question: Question?
    
    //MARK: - initialization
    
    init(question: Question? = nil) {
        self.question = question
        super.init()
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        register(AnswerCell.self, forCellWithReuseIdentifier: AnswerCell.identifier)
    }
    
    func cellForItem(at index: Int) -> AnswerCell? {
        cellForItem(at: IndexPath(item: index, section: 0)) as? AnswerCell
    }
    
    func removeTwoAnswers(_ answersToRemove: [Int]) {
        for index in answersToRemove {
            cellForItem(at: index)?.fadeElements()
        }
    }
    
    func selectHint(_ answerIndex: Int) {
        cellForItem(at: answerIndex)?.selectCell()
    }
}

extension AnswersCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCell.identifier, for: indexPath) as? AnswerCell else { return UICollectionViewCell() }
        
        if let question {
            cell.configure(with: question.answers[indexPath.row])
        }
        
        return cell
    }
    
    func configureAnswers(for question: Question) {
        self.question = question
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deselectItem(at: indexPath, animated: true)
        tapDelegate?.processTap(at: indexPath.row)
    }
}


