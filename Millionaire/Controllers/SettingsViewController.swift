//
//  SettingsController.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 17.06.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: - naming
    
    private let game = Game.shared
    
    private lazy var settingsView: SettingsTableView = {
        let view = SettingsTableView(shuffled: game.shuffled)
        view.tableVieweDlegate = self
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        navigationItem.title = "Настройки"
        setupView()
    }
    
    //MARK: - functions
    
    private func setupView() {
        view.addSubview(settingsView)
        
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension SettingsViewController: SettingsTableViewDelegate {
    func saveShuffleMode(shuffled: Bool) {
        game.changeShuffleMode(shuffled)
    }
}
