//
//  AddQuestionsViewController.swift
//  Millionaire
//
//  Created by Ксения Маричева on 02.09.2024.
//

import UIKit

protocol NewQuestionsViewControllerDelegate: AnyObject {
    func refresh(with questions: [Question])
}

class NewQuestionsViewController: UIViewController {
    
    // MARK: - naming
    
    weak var delegate: NewQuestionsViewControllerDelegate?
    
    private var usersQuestions: [Question] { Game.shared.userQuestions }
    
    private lazy var tableView: NewQuestionsTableView = {
        let view = NewQuestionsTableView(questions: usersQuestions)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewDelegate = self
        delegate = view
        return view
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        setupNavigationController()
    }
    
    // MARK: - Setup view methods
    
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupNavigationController() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Добавленые вопросы:"
        navigationController?.navigationBar.tintColor = .white
    }
}

extension NewQuestionsViewController: NewQuestionsTableViewDelegate {
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Заполните все поля и выбере правельный ответ, что бы сохранть новый вопрос", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func saveQuestion(_ question: Question) {
        Game.shared.saveUserQuestion(question)
        self.delegate?.refresh(with: self.usersQuestions)
    }
    
    func deleteQuestion(_ question: Question) {
        Game.shared.deleteUserQuestion(question: question)
    }
}

