//
//  LoseView.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 17.05.2024.
//

import UIKit

protocol EndViewDelegate: AnyObject{
    func restartGame()
}

class EndView: UIView {
    
    //MARK: - naming
    
    let results: Int
    private lazy var won: Bool = { results == 100 }()
    
    weak var delegate: EndViewDelegate?
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "\(won ? "MISSION PASSED" : "WASTED")\n\(results)%"
        label.textColor = won ? UIColor.limeGreen :  UIColor.white
        label.font = Fonts.large
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    
//    private lazy var imageView: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.image = UIImage(named: "Win_Cat")
//        view.contentMode = .scaleAspectFill
//        view.isUserInteractionEnabled = true
//        return view
//    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .limeGreen
        button.setTitle("Закончить игру", for: .normal)
        button.setTitleColor(.gameGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        return button
    }()
    
    //MARK: - ininialization
    
    init(results: Int) {
        self.results = results
        super.init(frame: .zero)
        backgroundColor = .black 
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions

    private func setupView() {
        
        addSubview(resultLabel)
        addSubview(restartButton)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            centerXAnchor.constraint(equalTo: centerXAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 195),
            resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            restartButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            restartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc func restart() {
        delegate?.restartGame()
    }
}
