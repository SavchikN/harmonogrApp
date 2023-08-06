//
//  NewTaskViewController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 23/07/2023.
//

import UIKit
import SnapKit

//protocol NewTaskDelegate: class {
//    func taskDidAdd(task: Tasks)
//    
//}

class NewTaskViewController: UIViewController {
    
    let viewContext = StorageManager.shared.persistentContainer.viewContext
    let storageManager = StorageManager.shared
    var delegate: MainViewControllerDelegate!
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Task name:"
        title.font = UIFont(name: "Avenir Next", size: 20)
        title.textColor = .black
        return title
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Describe the task:"
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = .black
        return label
    }()
    
    private let descriptionTV: UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir Next", size: 18)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        textView.textAlignment = .center
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.backgroundColor = nil
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        return button
    }()
    
    let titleTF = LoginTFView()
    let taskTypeView = TaskTypeView()
    let tableView = TaskTableView()
    let mainVC: MainViewController?
    
    init(mainVC: MainViewController?) {
        self.mainVC = mainVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setConstraints()
    }
    
    func setupViews() {
        titleTF.loginTextField.placeholder = ""
        view.addSubview(titleTF)
        view.addSubview(descriptionTV)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(taskTypeView)
        view.addSubview(addButton)
    }
}

extension NewTaskViewController {
    @objc func addButtonPressed() {
        guard let taskName = titleTF.loginTextField.text, !taskName.isEmpty,
              let description = descriptionTV.text, !description.isEmpty else {
            showAlert(title: "Oops!", message: "Please fill in all fields")
            return
        }
        
        let task = ToDo(context: viewContext)
        task.title = taskName
        task.descript = description
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                print("vse OK \(storageManager.taskList.count)")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        delegate.reloadData()
        dismiss(animated: true)
        print("ЗДЕСЬ")
        
//        let newTask = Tasks(name: taskName, description: description, taskType: taskTypeView.currentType)
//        Tasks.addTask(task: newTask)
//        mainVC?.tableView.tableView.reloadData()
//        dismiss(animated: true)
    }
}

extension NewTaskViewController {
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(125)
            make.leading.equalTo(view.snp.leading).inset(50)
            make.width.equalTo(200)
        }
        
        titleTF.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(150)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTF.snp.bottom).inset(-10)
            make.bottom.equalTo(descriptionTV.snp.top).inset(3)
            make.leading.equalTo(view.snp.leading).inset(50)
            make.width.equalTo(250)
        }
        
        descriptionTV.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(120)
            make.width.equalTo(300)
        }
        
        taskTypeView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTV.snp.bottom).inset(-25)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.height.equalTo(190)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(taskTypeView.snp.bottom).inset(-30)
            make.leading.equalTo(view.snp.leading).inset(60)
            make.trailing.equalTo(view.snp.trailing).inset(60)
            make.height.equalTo(50)
        }
    }
}

extension NewTaskViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.titleTF.loginTextField.text = ""
            self.descriptionTV.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
