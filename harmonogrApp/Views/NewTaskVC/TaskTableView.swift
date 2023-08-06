//
//  TaskTableView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 26/07/2023.
//

import UIKit
import SnapKit

class TaskTableView: UIView {
    
    private let viewContext = StorageManager.shared.persistentContainer.viewContext
    private let storageManager = StorageManager.shared
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDelegates()
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViews() {
        addSubview(tableView)
        tableView.rowHeight = 50
    }
}

extension TaskTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageManager.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tasks = storageManager.taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = tasks.title
        cell.contentConfiguration = content
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let infoVC = InfoViewController()
//        infoVC.nameLabel.text = doList[indexPath.row].name
//        infoVC.descriptionLabel.text = doList[indexPath.row].description
//        infoVC.statusView.backgroundColor = doList[indexPath.row].status
//        
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = storageManager.taskList[indexPath.row]
            viewContext.delete(task)
            
            do {
                try viewContext.save()
                storageManager.taskList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
    
}

extension TaskTableView {
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.leading.equalTo(snp.leading).inset(0)
            make.trailing.equalTo(snp.trailing).inset(0)
            make.bottom.equalTo(snp.bottom).inset(0)
        }
    }
}
