//
//  CategoryViewCell.swift
//  Test Menu
//
//  Created by Sergey Savinkov on 17.01.2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "name"
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "count"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var menuID = String()
    
    static let collectionViewCellID = "collectionViewCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        addSubview(nameCategoryLabel)
        addSubview(countLabel)
        addSubview(cellImageView)
    }
    
    func cellConfigure(model: MenuListItem) {
        nameCategoryLabel.text = model.name
        countLabel.text = "\(model.subMenuCount) товаров"
        menuID = model.menuID
        
        let urlString = "https://vkus-sovet.ru" + model.image
        let url = URL(string: urlString)!
        
        ServiceManager.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let data):
                let image = UIImage(data: data)
                self.cellImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: topAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: frame.width),
            cellImageView.heightAnchor.constraint(equalToConstant: frame.height / 2),
            
            nameCategoryLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -70),
            nameCategoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameCategoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
