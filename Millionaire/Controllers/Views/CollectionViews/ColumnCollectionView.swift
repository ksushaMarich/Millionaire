//
//  ColumnCollectionView.swift
//  Millionaire
//
//  Created by Ксения Маричева on 20.09.2024.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    
    init(inset: CGFloat) {
        super.init()
        minimumLineSpacing = inset
        minimumInteritemSpacing = inset
        sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpacingFlowLayout: UICollectionViewFlowLayout {
    
    init(inset: CGFloat) {
        super.init()
        minimumLineSpacing = inset
        minimumInteritemSpacing = inset
//        sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ColumnCollectionView: UICollectionView, UICollectionViewDelegate {

    // MARK: - naming
    
    private let numberOfColumns: CGFloat = 2
    private let inset: CGFloat = 28
    static var height: CGFloat = 180
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero, collectionViewLayout: SpacingFlowLayout(inset: inset))
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColumnCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width-inset)/numberOfColumns
        let height = (frame.height-inset)/numberOfColumns
        return CGSize(width: width, height: height)
    }
}
