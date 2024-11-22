//
//  TvView.swift
//  Millionaire
//
//  Created by User on 20.11.2024.
//

import UIKit

#warning("Новый класс экран")
class TvView: UIView {
    
    //MARK: - naming
    
    var questinon: String?
    
    private lazy var screenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ScreenColor")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var catImvageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Cat"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - init
    
    init(questinon: String?) {
        self.questinon = questinon
        super.init(frame: .zero)
        layer.masksToBounds = true
        layer.cornerRadius = 5
        backgroundColor = .gameGray
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    
    private func setupView() {
        addSubview(screenView)
        let screenConstraints = [screenView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                 screenView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                 screenView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 10/13),
                                 screenView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 13/17),]
        guard let questinon else {
            screenView.addSubview(catImvageView)
            NSLayoutConstraint.activate(screenConstraints + [
                
                
                catImvageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                catImvageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
            return
        }
        
    }
}
