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
    
    private lazy var tvView: TvView = {
        let view = TvView(isCat: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fakeButtonsStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 60
        return stackView
    }()
    
    private lazy var cross: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Сross")
        return view
    }()
    
    private lazy var buttons: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Buttons")
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
        backgroundColor = .black
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    private func setupView() {
        addSubview(tvView)
        addSubview(fakeButtonsStackVeiw)
        fakeButtonsStackVeiw.addArrangedSubview(cross)
        fakeButtonsStackVeiw.addArrangedSubview(buttons)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(resultButton)
    
        NSLayoutConstraint.activate([
            
            tvView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            tvView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 340/393),
            tvView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tvView.heightAnchor.constraint(equalTo: tvView.widthAnchor, multiplier: 13/17),
            
            fakeButtonsStackVeiw.topAnchor.constraint(equalTo: tvView.bottomAnchor, constant: 68),
            fakeButtonsStackVeiw.centerXAnchor.constraint(equalTo: centerXAnchor),
            fakeButtonsStackVeiw.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 280/393),
            fakeButtonsStackVeiw.heightAnchor.constraint(equalTo: fakeButtonsStackVeiw.widthAnchor, multiplier: 100/280),
            
            buttonStackView.widthAnchor.constraint(equalTo: tvView.widthAnchor),
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
