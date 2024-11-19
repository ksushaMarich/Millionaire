//
//  ResultsViewController.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 28.05.2024.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //MARK: - naming
    
    private lazy var resultView: ResultsCollectionView = {
        let view = ResultsCollectionView(results: Game.shared.records)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
    }
    
    //MARK: - functions
    
    private func setupView() {
        view.addSubview(resultView)
        
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationController() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Результаты:"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(showDeleteAlert))
    }
    
    @objc func showDeleteAlert() {
        let alertController = UIAlertController(title: "Удадилить результаты", message: "После удаления результатов, востановить их будет не возможно.", preferredStyle: .alert)
        let actionСancel = UIAlertAction(title: "Отмена", style: .cancel)
        let actionDelеte = UIAlertAction(title: "Удалить", style: .default) { _ in
            Game.shared.removeRecords()
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(actionСancel)
        alertController.addAction(actionDelеte)
        present(alertController, animated: true)
    }
}
