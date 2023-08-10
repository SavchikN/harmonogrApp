//
//  TaskTypeView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 23/07/2023.
//

import UIKit
import SnapKit

class TaskTypeView: UIView {
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return collectionView
    }()
    
    let taskTypes = ["Low", "Medium", "High"]
    let taskImages = [UIImage(named: "green"), UIImage(named: "orange"), UIImage(named: "red")]
    var currentType: Types = .low
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setDelegates()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskTypeView {
    private func setupViews() {
        backgroundColor = .gray
        addSubview(collectionView)
        collectionView.register(TypesCollectionViewCells.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TaskTypeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            currentType = .medium
        case 2:
            currentType = .low
        default:
            currentType = .high
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TypesCollectionViewCells else { return UICollectionViewCell() }
        cell.index = indexPath.row
        cell.typeLabel.text = taskTypes[indexPath.row]
        cell.typeImage.image = taskImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
}

extension TaskTypeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: 300,
            height: 50
        )
    }
}

extension TaskTypeView {
    private func setConstrains() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(-2)
            make.leading.equalTo(snp.leading).inset(0)
            make.trailing.equalTo(snp.trailing).inset(0)
            make.height.equalTo(300)
        }
    }
}
