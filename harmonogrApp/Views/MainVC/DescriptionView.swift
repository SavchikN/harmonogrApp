//
//  DescriptionView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 06/08/2023.
//

import UIKit
import SnapKit

class DescriptionView: UIView {
    
    let viewContext = StorageManager.shared.persistentContainer.viewContext
    let storageManager = StorageManager.shared
    
    var delegate: MainViewControllerDelegate!
    
    var dimmingView: UIView?
    
    var mainTitle: UILabel = {
        let title = UILabel()
        title.text = "Task Name"
        title.font = UIFont(name: "Avenir Next Medium", size: 25)
        title.textAlignment = .center
        return title
    }()
    
    var descriptionTextView: UITextView = {
        let description = UITextView()
        description.font = UIFont(name: "Avenir Next", size: 20)
        description.textAlignment = .center
        description.spellCheckingType = .no
        description.layer.borderColor = .none
        description.layer.borderWidth = 0
        description.isEditable = false
        return description
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        if let image = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)) {
            button.setImage(image, for: .normal)
        }
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.backgroundColor = .clear
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.backgroundColor = .clear
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 1
        
        setupSubviews(
            mainTitle,
            cancelButton,
            descriptionTextView,
            saveButton,
            editButton
        )
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(_ subview: UIView...) {
        subview.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func dismissAnimated() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.dimmingView?.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.dimmingView?.removeFromSuperview()
        }
    }
    
    func showAnimated(on parentViewController: MainViewController) {
        dimmingView = UIView(frame: parentViewController.view.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmingView?.tag = 1001
        
        parentViewController.view.addSubview(dimmingView!)
        parentViewController.view.addSubview(self)
        
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: []) {
            self.alpha = 1
            self.transform = .identity
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        dimmingView?.addGestureRecognizer(tapGesture)
    }
    
    func closeEdit(size float: CGFloat, isEnabled bool: Bool, color: CGColor, buttonColor: UIColor) {
        descriptionTextView.layer.borderColor = color
        descriptionTextView.layer.borderWidth = float
        descriptionTextView.layer.cornerRadius = 20
        descriptionTextView.isEditable = bool
        
        saveButton.setTitleColor(buttonColor, for: .normal)
        saveButton.isEnabled = bool
    }
}

extension DescriptionView {
    @objc func cancelButtonPressed() {
        dismissAnimated()
    }
    
    @objc private func tapGesture() {
        dismissAnimated()
    }
    
    @objc func editButtonPressed() {
        closeEdit(
            size: 1,
            isEnabled: true,
            color: CGColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 1),
            buttonColor: .blue
        )
    }
    
    @objc func saveButtonPressed() {
        guard let taskDescription = descriptionTextView.text, !description.isEmpty else {
            return
        }
        
        if let existingTask = storageManager.taskList.first(where: { $0.title == mainTitle.text }) {
            existingTask.descript = taskDescription
            
            if viewContext.hasChanges {
                do {
                    try viewContext.save()
                    print("vse OK \(storageManager.taskList.count)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        delegate?.reloadData()
        closeEdit(
            size: 0,
            isEnabled: false,
            color: CGColor(
                red: 255,
                green: 255,
                blue: 255,
                alpha: 0),
            buttonColor: .gray
        )
        print("save")
    }
}

extension DescriptionView {
    private func setConstraints() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(10)
            make.leading.equalTo(snp.leading).inset(20)
            make.trailing.equalTo(snp.trailing).inset(20)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).inset(-15)
            make.leading.equalTo(snp.leading).inset(20)
            make.trailing.equalTo(snp.trailing).inset(20)
            make.bottom.equalTo(saveButton.snp.top).inset(-10)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-10)
            make.leading.equalTo(snp.leading).inset(30)
            make.trailing.equalTo(editButton.snp.leading).inset(-10)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-10)
            make.leading.equalTo(saveButton.snp.trailing).inset(-10)
            make.trailing.equalTo(snp.trailing).inset(30)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).inset(20)
            make.leading.equalTo(snp.leading).inset(30)
            make.trailing.equalTo(snp.trailing).inset(30)
        }
    }
}

