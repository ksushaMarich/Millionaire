//
//  SettingsTableViewCell.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 17.06.2024.
//

import UIKit

class ShuffleSettingsCell: UITableViewCell {
    
    //MARK: - naming

    static let identifier = "ShuffleSettingsCell"
    
    var toggleClosure: ((Bool) -> ())?
    
    private lazy var pictureView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "shuffle")
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Перемешать"
        return label
    }()
    
    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = UIColor(named: "Win_Color")
        switcher.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        return switcher
    }()
    //MARK: - initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - functions
    
    private func setupCell() {
        contentView.addSubview(pictureView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(switcher)
        
        NSLayoutConstraint.activate([
            
            pictureView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pictureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: pictureView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 20),
            
            switcher.centerYAnchor.constraint(equalTo: pictureView.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    func configureMode(shuffled: Bool) {
       switcher.isOn = shuffled
    }
    
    @objc func toggleSwitch() {
        toggleClosure?(switcher.isOn)
    }
}
