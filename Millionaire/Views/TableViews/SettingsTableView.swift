//
//  SettingsView.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 17.06.2024.
//

import UIKit

protocol SettingsTableViewDelegate: AnyObject {
    func saveShuffleMode(shuffled: Bool)
}

class SettingsTableView: UITableView {

    //MARK: - naming
    
    weak var tableVieweDlegate: SettingsTableViewDelegate?
    
    private var shuffled: Bool
    
    //MARK: - initialization
    
    init(shuffled: Bool) {
        self.shuffled = shuffled
        super.init(frame: .zero, style: .grouped)
        backgroundColor = .systemGray6
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        register(ShuffleSettingsCell.self, forCellReuseIdentifier: ShuffleSettingsCell.identifier)
        dataSource = self
        delegate = self
        allowsSelection = false
    }
}

extension SettingsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShuffleSettingsCell.identifier, for: indexPath) as? ShuffleSettingsCell else { return UITableViewCell() }
        cell.configureMode(shuffled: shuffled)
        cell.toggleClosure = { shuffled in
            self.tableVieweDlegate?.saveShuffleMode(shuffled: shuffled)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension SettingsTableView: UITableViewDelegate {}
