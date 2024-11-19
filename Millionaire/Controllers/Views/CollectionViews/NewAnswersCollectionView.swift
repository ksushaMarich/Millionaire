//
//  AnswersTextFeldCollectionView.swift
//  TextFieldProject
//
//  Created by Ксения Маричева on 10.09.2024.
//

import UIKit

class NewAnswersCollectionView: ColumnCollectionView {
    
    //MARK: - naming
    
    var hasAnswers: Bool {
        var hasAnswers = true
        
        visibleCells.forEach { cell in
            guard let cell = cell as? AnswerTextFeldCell else { return }
            if !cell.hasAnswer {
                hasAnswers = false
                return
            }
        }
        
        return hasAnswers
    }
    
    var answers: [String] {
        var answers: [String] = []
        
        visibleCells.forEach { cell in
            guard let cell = cell as? AnswerTextFeldCell else { return }
            answers.append(cell.answer)
        }
        
        return answers
    }
    
    //MARK: - init
    
    override init() {
        super.init()
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - func
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        register(AnswerTextFeldCell.self, forCellWithReuseIdentifier: AnswerTextFeldCell.identifier)
    }
    
    func markRightAnswer(_ index: Int) {
        
        visibleCells.forEach { cell in
            guard let cell = cell as? AnswerTextFeldCell else { return }
            cell.markWrong()
        }
        
        let cell = cellForItem(at: IndexPath(item: index, section: 0)) as? AnswerTextFeldCell
        cell?.markCorrect()
    }
}

extension NewAnswersCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerTextFeldCell.identifier, for: indexPath) as? AnswerTextFeldCell else { return UICollectionViewCell() }
        cell.setPlaceholder("Ответ \(indexPath.row + 1)")
        return cell
    }
}


 
