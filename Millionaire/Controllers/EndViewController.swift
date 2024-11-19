//
//  LoseViewController.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 17.05.2024.
//

import UIKit

class EndViewController: UIViewController {
    
    //MARK: - naming
    
    let result: Int
    
    private lazy var endView: EndView = {
        let view = EndView(results: result)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - life cycle
    
    init(result: Int) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - functions
    
    private func setupView() {
        view.addSubview(endView)
        
        NSLayoutConstraint.activate([
            endView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            endView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            endView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension EndViewController: EndViewDelegate {
    
    func restartGame() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}
