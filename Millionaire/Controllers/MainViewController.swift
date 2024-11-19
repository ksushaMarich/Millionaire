//
//  ViewController.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 15.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: -  naming
   
    private lazy var mainView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewDelegate = self
        return view
    }()
    
    
    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupNavigationItem()
        setupUIView()
    }

    //MARK: - functions
    
    private func setupNavigationItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(openAddQuestions))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupUIView() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func openSettings() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func openAddQuestions() {
        navigationController?.pushViewController(NewQuestionsViewController(), animated: true)
    }
}

//MARK: - extensions

extension MainViewController: MainViewDelegate {

    func startGame() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    func showResults() {
        navigationController?.pushViewController(ResultsViewController(), animated: true)
    }
    
}

