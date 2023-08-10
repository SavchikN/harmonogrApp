//
//  MainViewController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 25/05/2023.
//

import UIKit
import SnapKit

protocol MainViewControllerDelegate {
    func reloadData()
}

class MainViewController: UIViewController {
    
    private let viewContext = StorageManager.shared.persistentContainer.viewContext
    private let storageManager = StorageManager.shared
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Task", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.backgroundColor = nil
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return sc
    }()
    
    let titleView = TitleView()
    let tableView = TaskTableView()
    
    let segmentedTitles = ["High", "Medium", "Low"]
    var selectedSegmentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
        navigationController?.navigationItem.backBarButtonItem = .none
        view.backgroundColor = .white
        tableView.delegate = self
        
        setupViews()
        configure()
        setConstraints()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(segmentedControl)
        view.addSubview(titleView)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    private func configure() {
        for (index, title) in segmentedTitles.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
    }
    
    private func fetchData() {
        let fetchRequest = ToDo.fetchRequest()
        do {
            storageManager.taskList = try viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension MainViewController: TaskTableViewDelegate {
    func didSelectAt(_ task: ToDo, index indexPath: IndexPath) {
        tableView.tableView.deselectRow(at: indexPath, animated: true)
        
        let descriptionView = DescriptionView(frame: CGRect(x: 0, y: 0, width: 300, height: 330))
        descriptionView.center = tableView.center
        
        descriptionView.mainTitle.text = task.title
        descriptionView.descriptionLabel.text = task.descript
        
        descriptionView.showAnimated(on: self)
        
    }
}

extension MainViewController {
    @objc func addButtonPressed() {
        let newTaskVC = NewTaskViewController(mainVC: self)
        newTaskVC.delegate = self
        present(newTaskVC, animated: true)
    }
}

extension MainViewController: MainViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.tableView.reloadData()
    }
}

extension MainViewController {
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(0)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(addButton.snp.top).inset(-5)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(segmentedControl.snp.top).inset(-20)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(100)
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(150)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(150)
            make.width.equalTo(310)
        }
    }
}
