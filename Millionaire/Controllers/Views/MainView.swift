//
//  MainView.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 15.05.2024.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func startGame()
    func showResults()
}

class MainView: UIView {

    //MARK: - naming
    
    weak var viewDelegate: MainViewDelegate?
    
    private lazy var titleColor: UIColor = .gameGray
    
    private let font = Fonts.main
    
    private lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "MainView")
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = .limeGreen
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("RESULTS", for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .limeGreen
        button.addTarget(self, action: #selector(showResult), for: .touchUpInside)
        return button
    }()
    
    //MARK: - initialization
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    private func setupView() {
        addSubview(mainImageView)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(resultButton)
        
        NSLayoutConstraint.activate([
            
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            buttonStackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc func startGame() {
        viewDelegate?.startGame()
    }
    
    @objc func showResult() {
        viewDelegate?.showResults()
    }
}
