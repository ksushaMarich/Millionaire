//
//  ResultsCollectionView.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 07.06.2024.
//

import UIKit

class ResultsCollectionView: UICollectionView {

    //MARK: - name
    
    private lazy var numberOfColumns: CGFloat = 2
    private let inset: CGFloat = 8
    
    let results: [RecordsOriginator]
    
    init(results: [RecordsOriginator]) {
        self.results = results
        super.init(frame: .zero, collectionViewLayout: FlowLayout(inset: inset))
        backgroundColor = .black
        setupView()
    }
    
    //MARK: - initialization
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        register(ResultsCell.self, forCellWithReuseIdentifier: ResultsCell.identifier)
    }
}

extension ResultsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { return UICollectionViewCell() }
        
        cell.configure(result: results[indexPath.row])

        return cell
    }
}

extension ResultsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeWidth = ((frame.width - inset * (numberOfColumns + 1))/numberOfColumns)
        return CGSize(width: sizeWidth, height: sizeWidth/3)
    }
}
