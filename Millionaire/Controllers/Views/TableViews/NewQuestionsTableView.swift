//
//  NewQuestionsTableView.swift
//  Millionaire
//
//  Created by Ксения Маричева on 02.09.2024.
//

import UIKit

protocol NewQuestionsTableViewDelegate: AnyObject {
    func showErrorAlert()
    func saveQuestion(_ question: Question)
    func deleteQuestion(_ question: Question)
}

class NewQuestionsTableView: UITableView {
    
    enum AddingQuestionCellType {
        case userQuestion, newQuestion, plus
    }
    
    // MARK: - naming
    
    weak var viewDelegate: NewQuestionsTableViewDelegate?
    
    private var questions: [Question]
    
    private var isDefaultMode = true
    
    // MARK: - init
    
    init(questions: [Question]) {
        self.questions = questions
        super.init(frame: .zero, style: UITableView.Style.plain)
        backgroundColor = .black
        delegate = self
        dataSource = self
        separatorColor = .clear
        register(UserQuestionsCell.self, forCellReuseIdentifier: UserQuestionsCell.identifier)
        register(NewQuestionFormCell.self, forCellReuseIdentifier: NewQuestionFormCell.identifier)
        register(PlusCell.self, forCellReuseIdentifier: PlusCell.identifier)
        addGestureRecognizersObservers()
        allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineCellType(by indexPath: IndexPath) -> AddingQuestionCellType {
        switch indexPath.section {
        case 0:
            return .newQuestion
        default:
            return isDefaultMode && !questions.isEmpty ?  .plus : .userQuestion
        }
    }
    
    // MARK: - Keyboard management
    
    func addGestureRecognizersObservers() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        setContentOffset(CGPoint(x: 0, y: (UserQuestionsCell.totalHeight * CGFloat(questions.count))), animated: true)
    }
    
    @objc func keyboardWillHide() {
        setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension NewQuestionsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch defineCellType(by: indexPath) {
        case .newQuestion:
            return NewQuestionFormCell.totalHeight
        case .userQuestion:
            return UserQuestionsCell.totalHeight
        case .plus:
            return PlusCell.totalHeight
        }
    }
    
    func newQuestionFormCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewQuestionFormCell.identifier, for: indexPath) as? NewQuestionFormCell else { return UITableViewCell() }
        cell.cellDelegate = self
        return cell
    }
    
    func userQuestionsCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserQuestionsCell.identifier, for: indexPath) as? UserQuestionsCell else { return UITableViewCell() }
        cell.configure(with: questions[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func plusCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlusCell.identifier, for: indexPath) as? PlusCell else { return UITableViewCell() }
        cell.cellDelegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? questions.count : 1
    }
    
    func cellForRowAt(_ indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        switch defineCellType(by: indexPath) {
        case .newQuestion:
            return newQuestionFormCell(for: indexPath, in: tableView)
        case .userQuestion:
            return userQuestionsCell(for: indexPath, in: tableView)
        case .plus:
            return plusCell(for: indexPath, in: tableView)
        }
    }
    
    enum CellType {
        case new
        case user
        case plus
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //как вариант, или взять код ниже просто
        // сделать enum с 3 значениям по типу ячейки
        // enum cellTipe: plus, new, user
        //enum cellytpe {case new,plus,user}
        // вынести этот алгоритм в отдельный метод(входной параметр индесПаф а возвращает тип ячейки)
        
        cellForRowAt(indexPath, in: tableView)
    }
}

extension NewQuestionsTableView: NewQuestionFormCellDelegate {
    func saveQuestion(_ question: Question) {
        viewDelegate?.saveQuestion(question)
    }
    
    func showErrorAlert() {
        viewDelegate?.showErrorAlert()
    }
}

extension NewQuestionsTableView: UserQuestionsCellDelegate {
    func deleteQuestion(_ question: Question) {
        
        viewDelegate?.deleteQuestion(question)
        questions.removeAll { $0 == question }
        
        if questions.isEmpty && isDefaultMode {
            reloadData()
        } else {
            reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
}

extension NewQuestionsTableView: NewQuestionsViewControllerDelegate {

    func refresh(with questions: [Question]) {
        self.questions = questions
        isDefaultMode = true
        reloadData()
    }
}

extension NewQuestionsTableView: PlusCellDelegate {
    func switchToNewQuestionFormMode() {
        isDefaultMode = false
        //reloadRows(at: [IndexPath(row: 0, section: 1)], with: .fade)
        reloadData()
    }
}

    
